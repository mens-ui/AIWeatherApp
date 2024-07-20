//
//  ViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit
import CoreLocation

import Alamofire

class MainViewController: UIViewController {
  
  var mainView: MainView!
  
  override func loadView() {
    mainView = MainView(frame: UIScreen.main.bounds)
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    // 위치 업데이트 핸들러 설정
    LocationModel.shared.locationUpdateHandler = { [weak self] in
      self?.getCurrentData()
    }
    
    requestPermissions()
    setUpTableView()
    
    // 초기 위치 데이터 요청
    let locationManager = CLLocationManager()
    if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
      LocationModel.shared.requestLocation()
    }
  }
  
  func requestPermissions() {
    // 알림 권한 요청
    NotificationModel.shared.requestAuthorization { granted in
      if !granted {
        print("알림 권한이 거부되었습니다.")
      }
    }
    
    // 위치 권한 요청
    LocationModel.shared.requestAuthorization()
  }
  
  func getCurrentData() {
    guard let latitude = UserDefaults.standard.value(forKey: "latitude") as? Double,
          let longitude = UserDefaults.standard.value(forKey: "longitude") as? Double else {
      print("위도와 경도 값이 없습니다.")
      return
    }
    
    NetworkManager.shared.getCurrentData(latitude: latitude, longitude: longitude) { weatherData in
      if let weatherData = weatherData {
        DispatchQueue.main.async {
          self.mainView.weatherLabel.text = weatherData.weather.first!.description
          self.mainView.locationLabel.text = weatherData.name
          self.mainView.longlong2.image = UIImage(named: weatherData.weather.first!.main)
          self.mainView.temperatureLabel.text! += String(Int(weatherData.main.temp)) + "ºC"
          self.mainView.highTemperatureLabel.text! += changeFormat.shared.changeString(weatherData.main.temp_max)! + "ºC"
          self.mainView.lowTemperatureLabel.text! += changeFormat.shared.changeString(weatherData.main.temp_min)! + "ºC"
          self.mainView.humidityLabel.text! += String(Int(weatherData.main.humidity))
        }
      }
    }
  }
  
  func setUpTableView() {
    mainView.weekWeather.dataSource = self
    mainView.weekWeather.delegate = self
    mainView.weekWeather.register(WeatherTableViewCell.self,
                                  forCellReuseIdentifier: WeatherTableViewCell.identifier)
    mainView.weekWeather.rowHeight = 60
  }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    15
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier,
                                                   for: indexPath) as? WeatherTableViewCell else {
      return UITableViewCell()
    }
    
    guard let latitude = UserDefaults.standard.value(forKey: "latitude") as? Double,
          let longitude = UserDefaults.standard.value(forKey: "longitude") as? Double else {
      print("위도와 경도 값이 없습니다.")
      return cell
    }
    
    NetworkManager.shared.getWeekData(latitude: latitude, longitude: longitude) { weatherData in
      if let weatherData = weatherData {
        DispatchQueue.main.async {
          cell.lowTemperature.text = "최저 " + changeFormat.shared.changeString(weatherData.list[indexPath.row].main.temp_min)! + "ºC"
          cell.highTemperature.text = "최고 " + changeFormat.shared.changeString(weatherData.list[indexPath.row].main.temp_max)! + "ºC"
          if let day = changeFormat.shared.extractDayAndTime(from: weatherData.list[indexPath.row].dt_txt) {
            cell.timeLabel.text = day
          }
        }
      }
    }
    NetworkManager.shared.getIcon(latitude: latitude, longitude: longitude) { weatherData in
      if let weatherData = weatherData {
        DispatchQueue.main.async {
          cell.weatherImage.image = weatherData
        }
      }
    }
    return cell
  }
}
