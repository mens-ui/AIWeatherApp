//
//  ViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

import Alamofire

class MainViewController: UIViewController {
  
  struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
  }
  
  struct Main: Decodable {
    let temp: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
  }
  
  struct Weather: Decodable {
    let main: String
  }
  
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
    mainView?.weatherLabel.text = "더움"
    getData()
  }
  
  func getData() {
    AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(myAPIKey)&units=metric", method: .get).responseDecodable(of: WeatherResponse.self) { response in
      switch response.result {
      case .success(let value):
        DispatchQueue.main.async {
          if let weather = value.weather.first {
            print(weather.main)
            self.mainView.weatherLabel.text = weather.main
          }
          self.mainView.locationLabel.text = value.name
          print(value.main.temp)
        }
      case .failure(let error):
        print(error)
      }
    }
  }
}
