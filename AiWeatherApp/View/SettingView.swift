//
//  SettingView.swift
//  AiWeatherApp
//
//  Created by 김동현 on 7/17/24.
//

import UIKit
import CoreLocation

import SnapKit

class SettingView: UIView {
  
  let notificationSwitch = UISwitch()
  let timePicker: UIDatePicker = {
    let timePicker = UIDatePicker()
    timePicker.datePickerMode = .time
    return timePicker
  }()
  let locationButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("위치", for: .normal)
    return button
  }()
  let saveButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("저장", for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    backgroundColor = .white
    
    [
      notificationSwitch,
      timePicker,
      locationButton,
      saveButton
    ].forEach { self.addSubview($0) }
    
    notificationSwitch.snp.makeConstraints {
      $0.top.equalToSuperview().offset(100)
      $0.centerX.equalToSuperview()
    }
    
    timePicker.snp.makeConstraints {
      $0.top.equalTo(notificationSwitch.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
    
    locationButton.snp.makeConstraints {
      $0.top.equalTo(timePicker.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
    
    saveButton.snp.makeConstraints {
      $0.top.equalTo(locationButton.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
  }
}
