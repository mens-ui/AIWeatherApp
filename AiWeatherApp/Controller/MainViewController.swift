//
//  ViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

import Alamofire

class MainViewController: UIViewController {
  
  let myAPIKey = "cec8dc376cea68811d800a55218dbeed"
  let lat = 37.56
  let lon = 126.97
  let data = Data()
  var mainView: MainView!
  
  override func loadView() {
    mainView = MainView(frame: UIScreen.main.bounds)
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    getData()
  }
  
  func getData() {
    NetworkManager.shared.getCurrentData { weatherData in
      if let weatherData = weatherData {
        DispatchQueue.main.async {
          self.mainView.weatherLabel.text = weatherData.weather.first!.description
          self.mainView.locationLabel.text = weatherData.name
          self.mainView.temperatureLabel.text! += String(Int(weatherData.main.temp)) + "ºC"
          self.mainView.highTemperatureLabel.text! += String(Int(weatherData.main.temp_max)) + "ºC"
          self.mainView.lowTemperatureLabel.text! += String(Int(weatherData.main.temp_min)) + "ºC"
          self.mainView.humidityLabel.text! += String(Int(weatherData.main.humidity))
        }
      }
    }
  }
}
