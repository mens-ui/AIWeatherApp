//
//  Model.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import Foundation

struct CurrentWeatherResult: Codable {
  let weather: [Weather]
  let main: WeatherMain
  let name: String
}

struct Weather: Codable {
  let main: String
  let description: String
  let icon: String
}

struct WeatherMain: Codable {
  let temp: Double
  let temp_min: Double
  let temp_max: Double
  let humidity: Int
}
