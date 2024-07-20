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
    imageView.contentMode = .scaleToFill
    imageView.layer.cornerRadius = 55
    return imageView
  }()
  
  lazy var weekWeather: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    return tableView
  }()
  
  private lazy var mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.backgroundColor = .systemBackground
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private lazy var weatherStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private lazy var imageView: UIView = {
    let view = UIView()
    return view
  }()
  
  private lazy var tempStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    stackView.alignment = .center
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
    self.addSubview(mainStackView)
    [weatherStackView, weekWeather].forEach { mainStackView.addArrangedSubview($0) }
    [imageView, tempStackView].forEach { weatherStackView.addArrangedSubview($0) }
    [
      temperatureLabel,
      highTemperatureLabel,
      lowTemperatureLabel,
      yellowAir,
      humidityLabel
    ].forEach { tempStackView.addArrangedSubview($0) }
    [weatherLabel, locationLabel, longlong2].forEach { imageView.addSubview($0) }
  }
  
  func setConstraints() {
    mainStackView.snp.makeConstraints {
      $0.edges.equalTo(self.safeAreaLayoutGuide).inset(10)
    }
    
    weatherLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(5)
      $0.centerX.equalToSuperview()
    }
    
    locationLabel.snp.makeConstraints {
      $0.top.equalTo(weatherLabel.snp.bottom).offset(5)
      $0.bottom.equalTo(longlong2.snp.top).offset(-5)
      $0.centerX.equalToSuperview()
    }
    
    longlong2.snp.makeConstraints {
      $0.top.equalTo(locationLabel.snp.bottom).offset(5)
      $0.bottom.equalToSuperview().inset(5)
      $0.width.equalTo(longlong2.snp.height)
      $0.width.equalTo(110)
      $0.centerX.equalToSuperview()
    }
  }
}

