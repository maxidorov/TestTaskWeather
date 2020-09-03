//
//  WeatherNetworkManager.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import Foundation

// Кастомные ошибки для лучше обработки
enum WeatherParsingError: Error {
    case noInternetConnection
    case cityNameIsNil
    case stringUrlIsNil
    case invalidURL
    case internalError
    case dataIsNil
    case responseIsNotHttp
    case responseStatusCodeError
    case jsonDecoderError
    case locationNotFound
}

protocol IWeatherNetworkingManager {
    func getWeatherIn(city: String?, completion: @escaping((Result<WeatherDescription, WeatherParsingError>) -> ()))
}

class WeatherNetworkingManager {
    
    var reachabilityManager: IReachabilityManager!
    
    private func getWeatherDescription(stringURL: String?, completion: @escaping((Result<WeatherDescription, WeatherParsingError>) -> ())) {
        
        guard let stringURL = stringURL else {
            completion(.failure(.stringUrlIsNil))
            return
        }
        
        var weatherDescription = WeatherDescription()
        
        guard let url = URL(string: stringURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("0643cd45-3cab-43f6-86a7-851c59be0cf5", forHTTPHeaderField: "X-Yandex-API-Key")
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            switch self?.reachabilityManager.connectionStatus() {
            case .offline, .unknown:
                completion(.failure(.noInternetConnection))
            default:
                break
            }
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(.internalError))
                    return
                }
                
                guard let jsonData = data else {
                    completion(.failure(.dataIsNil))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.responseIsNotHttp))
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    completion(.failure(.responseStatusCodeError))
                    return
                }

                do {
                    let jsonDecoder = JSONDecoder()
                    weatherDescription = try jsonDecoder.decode(WeatherDescription.self, from: jsonData)
                    completion(.success(weatherDescription))
                } catch {
                    completion(.failure(.jsonDecoderError))
                }
            }.resume()
        }
    }
}

extension WeatherNetworkingManager: IWeatherNetworkingManager {
    func getWeatherIn(city: String?, completion: @escaping((Result<WeatherDescription, WeatherParsingError>) -> ())) {
        
        guard let city = city else {
            completion(.failure(.cityNameIsNil))
            return
        }
        
        guard let location = CitiesDataProvider.citiesNamesToLocations[city] else {
            completion(.failure(.locationNotFound))
            return
        }
        
        let stringURL = NetworkingHelper.buildWeatherURLFromLocation(location)
        getWeatherDescription(stringURL: stringURL) { (result) in
            switch result {
            case .success(let weatherDescription):
                completion(.success(weatherDescription))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
