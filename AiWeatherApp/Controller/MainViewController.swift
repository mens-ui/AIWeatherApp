//
//  ViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

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
    getCurrentData()
    setUpTableView()
  }
  
  func getCurrentData() {
    NetworkManager.shared.getCurrentData { weatherData in
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
    mainView.weekWeather.register(TableViewCell.self,
                                  forCellReuseIdentifier: TableViewCell.identifier)
    mainView.weekWeather.rowHeight = 60
  }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    15
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier,
                                                   for: indexPath) as? TableViewCell
    else { return UITableViewCell() }
    NetworkManager.shared.getWeekData { weatherData in
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
    NetworkManager.shared.getIcon { weatherData in
      if let weatherData = weatherData {
        DispatchQueue.main.async {
          cell.weatherImage.image = weatherData
        }
      }
    }
    return cell
  }
}
