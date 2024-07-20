//
//  NetworkManager.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/20/24.
//

import Foundation

class NetworkManager {
  
  static let shared = NetworkManager()
  
  func getCurrentData(_ completion: @escaping (CurrentWeatherResult?) -> Void) {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "OPEN_WEATHER_API_KEY") as? String else { return }
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.56&lon=125.97&units=metric&appid=\(apiKey)&lang=kr")!
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
      do {
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode(CurrentWeatherResult.self, from: data)
        completion(jsonData)
      } catch {
        completion(nil)
      }
    }
    task.resume()
  }
  
  func getWeekData(_ completion: @escaping (WeekWeatherResult?) -> Void) {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "OPEN_WEATHER_API_KEY") as? String else { return }
    let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=37.56&lon=125.97&units=metric&appid=\(apiKey)&lang=kr")!
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
      do {
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode(WeekWeatherResult.self, from: data)
        completion(jsonData)
      } catch {
        completion(nil)
      }
    }
    task.resume()
  }
}
