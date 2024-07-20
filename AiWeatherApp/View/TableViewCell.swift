//
//  View.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

import SnapKit

final class TableViewCell: UITableViewCell {
  static let identifier = "weatherList"
  
  lazy var dayLabel: UILabel = {
    let label = UILabel()
    label.text = "요일"
    return label
  }()
  
  lazy var lowTemperature: UILabel = {
    let label = UILabel()
    label.text = "0"
    return label
  }()
  
  lazy var highTemperature: UILabel = {
    let label = UILabel()
    label.text = "100"
    return label
  }()
  
  lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    return label
  }()
  
  lazy var weatherImage: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .gray
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    [
      dayLabel,
      weatherImage,
      lowTemperature,
      highTemperature,
      timeLabel
    ].forEach { contentView.addSubview($0) }
  }
  
  func setConstraints() {
    dayLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(10)
      $0.centerY.equalToSuperview()
    }
    
    weatherImage.snp.makeConstraints {
      $0.leading.equalTo(dayLabel.snp.trailing).offset(10)
      $0.width.size.equalTo(20)
      $0.centerY.equalToSuperview()
    }
    
    lowTemperature.snp.makeConstraints {
      $0.leading.equalTo(weatherImage.snp.trailing).offset(10)
      $0.centerY.equalToSuperview()
    }
    
    highTemperature.snp.makeConstraints {
      $0.leading.equalTo(lowTemperature.snp.trailing).offset(10)
      $0.centerY.equalToSuperview()
    }
    
    timeLabel.snp.makeConstraints {
      $0.leading.equalTo(highTemperature.snp.trailing).offset(10)
      $0.centerY.equalToSuperview()
    }
  }
}
