//
//  MainView.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

import SnapKit

class MainView: UIView {
  lazy var weatherLabel: UILabel = {
    let label = UILabel()
    label.text = "맑음"
    label.textAlignment = .center
    return label
  }()
  
  lazy var locationLabel: UILabel = {
    let label = UILabel()
    label.text = "서울"
    label.textAlignment = .center
    return label
  }()
  
  lazy var temperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "현재 온도: "
    return label
  }()
  
  lazy var humidityLabel: UILabel = {
    let label = UILabel()
    label.text = "습도: "
    return label
  }()
  
  lazy var highTemperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "최고 온도: "
    return label
  }()
  
  lazy var lowTemperatureLabel: UILabel = {
    let label = UILabel()
    label.text = "최저 온도: "
    return label
  }()
  
  lazy var yellowAir: UILabel = {
    let label = UILabel()
    label.text = "미세먼지 나쁨"
    return label
  }()
  
  lazy var longlong2: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .gray
    imageView.clipsToBounds = true
    imageView.contentMode = .center
    imageView.layer.cornerRadius = 50
    return imageView
  }()
  
  lazy var weekWeather: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .gray
    return tableView
  }()
  
  private lazy var weatherStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.backgroundColor = .systemBackground
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillProportionally
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    self.addSubview(weatherStackView)
    
    [
      weatherLabel,
      locationLabel,
      longlong2,
      temperatureLabel,
      humidityLabel,
      highTemperatureLabel,
      lowTemperatureLabel,
      yellowAir,
      weekWeather
    ].forEach { weatherStackView.addArrangedSubview($0)}
  }
  
  func setConstraints() {
    weatherStackView.snp.makeConstraints {
      $0.edges.equalTo(self.safeAreaLayoutGuide).inset(30)
    }
    
    longlong2.snp.makeConstraints {
      $0.width.height.equalTo(100)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.centerX).offset(-50)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.centerX).offset(50)
    }
    
    weekWeather.snp.makeConstraints {
      $0.height.equalTo(300)
      $0.bottom.leading.trailing.equalToSuperview().inset(10)
    }
   
    
    [
      weatherLabel,
      locationLabel,
      temperatureLabel,
      humidityLabel,
      highTemperatureLabel,
      lowTemperatureLabel,
      yellowAir
    ].forEach { $0.snp.makeConstraints {
      $0.left.equalToSuperview()
      }}
  }
}

