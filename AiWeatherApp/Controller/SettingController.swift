//
//  SettingController.swift
//  AiWeatherApp
//
//  Created by 김동현 on 7/17/24.
//

import UIKit

class SettingController: UIViewController {
  
  private var settingView = SettingView()
  
  override func loadView() {
    settingView = SettingView(frame: UIScreen.main.bounds)
    self.view = settingView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 알림 권한 요청
//    NotificationModel
    
    // 위치 권한 요청
    LocationModel.shared.requestAuthorization()
    
    // Target 설정
    settingView.locationButton.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
    settingView.saveButton.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
  }
  
  @objc func getLocation() {
    LocationModel.shared.requestLocation()
  }
  
  @objc func saveSettings() {
    let alertController = UIAlertController(title: nil, message: "저장하시겠습니까?", preferredStyle: .alert)
    let yesAction = UIAlertAction(title: "네", style: .default) { _ in
      // 설정 저장 로직 추가
      if self.settingView.notificationSwitch.isOn {
//        notificationmod
      }
    }
    let noAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
    alertController.addAction(yesAction)
    alertController.addAction(noAction)
    present(alertController, animated: true, completion: nil)
  }
  
}
