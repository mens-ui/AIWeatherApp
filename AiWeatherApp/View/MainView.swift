//
//  MainView.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

class MainView: UIView {
  
  lazy var weatherLabel: UILabel = {
    let label = UILabel()
    label.text = "날씨"
    return label
  }()
  
  lazy var locationLabel: UILabel = {
    let label = UILabel()
    label.text = "위치"
    return label
  }()
  
  lazy var temperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "온도"
    return label
  }()
  
  lazy var humidityLabel: UILabel = {
    let label = UILabel()
    label.text = "습도"
    return label
  }()
  
  lazy var highTemperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "최고 온도"
    return label
  }()
  
  lazy var lowTemperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "최저 온도"
    return label
  }()
  
  lazy var yellowAir: UILabel = {
    let label = UILabel()
    label.text = "미세먼지"
    return label
  }()
  
  lazy var weekWeather: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .gray
    return tableView
  }()
  
  private lazy var weatherStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.backgroundColor = .blue
    stackView.axis = .vertical
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    self.addSubview(weatherStackView)
    
    [
      weatherLabel,
      locationLabel,
      temperatureLabel,
      humidityLabel,
      highTemperatureLabel,
      lowTemperatureLabel,
      yellowAir,
      weekWeather
    ].forEach { weatherStackView.addArrangedSubview($0)}
  }
  
  func setConstraints() {
    weatherStackView.
  }
  
}
