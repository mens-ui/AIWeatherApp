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
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.56&lon=125.97&units=metric&appid=cec8dc376cea68811d800a55218dbeed&lang=kr")!
    
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
  
  //api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
}
