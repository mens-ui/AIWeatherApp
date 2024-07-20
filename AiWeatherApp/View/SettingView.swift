//
//  SettingView.swift
//  AiWeatherApp
//
//  Created by 김동현 on 7/17/24.
//

import UIKit

import SnapKit

class SettingView: UIView {
  
  let notificationLabel: UILabel = {
    let label = UILabel()
    label.text = "알림"
    return label
  }()
  let notificationSwitch = UISwitch()
  let timePickerLabel: UILabel = {
    let label = UILabel()
    label.text = "시간 설정"
    return label
  }()
  let timePicker: UIDatePicker = {
    let timePicker = UIDatePicker()
    timePicker.datePickerMode = .time
    return timePicker
  }()
  let locationButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("위치 권한 설정", for: .normal)
    return button
  }()
  
  let notificationStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    return stackView
  }()
  let timePickerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    return stackView
  }()
  let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 50
    stackView.alignment = .center
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    backgroundColor = .systemBackground
    
    [
      notificationLabel,
      notificationSwitch
    ].forEach { notificationStackView.addArrangedSubview($0) }
    
    [
      timePickerLabel,
      timePicker
    ].forEach { timePickerStackView.addArrangedSubview($0) }
    
    [
      notificationStackView,
      timePickerStackView,
      locationButton
    ].forEach { mainStackView.addArrangedSubview($0) }
    
    [
      mainStackView
    ].forEach { self.addSubview($0) }
    
    mainStackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(200)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
  }
}
