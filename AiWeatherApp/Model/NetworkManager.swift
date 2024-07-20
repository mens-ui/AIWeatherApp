//
//  NetworkManager.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/20/24.
//

import Foundation
import UIKit

class NetworkManager {
  
  static let shared = NetworkManager()
  let location = Data()
  
  func getCurrentData(_ completion: @escaping (CurrentWeatherResult?) -> Void) {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "OPEN_WEATHER_API_KEY") as? String else { return }
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&units=metric&appid=\(apiKey)&lang=kr")!
    
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
    let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&units=metric&appid=\(apiKey)&lang=kr")!
    
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
  
  func getIcon(_ completion: @escaping (UIImage?) -> Void) {
    getWeekData { weatherData in
      guard let weatherData = weatherData,
            let icon = weatherData.list.first?.weather.first?.icon,
            let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else {
        completion(nil)
        return
      }
      
      let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
        guard let data = data, error == nil, let image = UIImage(data: data) else {
          print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
          completion(nil)
          return
        }
        completion(image)
      }
      task.resume()
    }
  }
}
