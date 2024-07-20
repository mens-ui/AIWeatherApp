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
    setupNavigationBar()
    
    // 알림 권한 요청
    NotificationModel.shared.requestAuthorization { granted in
      if !granted {
        print("알림 권한이 거부되었습니다.")
      }
    }
    
    // 위치 권한 요청
    LocationModel.shared.requestAuthorization()
    
    // Target 설정
    settingView.locationButton.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
    
    // 설정값 불러오기
    loadSettings()
  }
  
  private func setupNavigationBar() {
    self.title = "설정"
    let applyButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(applyButtonTapped))
    navigationItem.rightBarButtonItem = applyButton
  }
  
  @objc func getLocation() {
    LocationModel.shared.requestLocation()
  }
  
  @objc func applyButtonTapped() {
    let selectedTime = settingView.timePicker.date
    let alertController = UIAlertController(title: nil, message: "저장하시겠습니까?", preferredStyle: .alert)
    let yesAction = UIAlertAction(title: "네", style: .default) { _ in
      // 설정 저장 로직 추가
      if self.settingView.notificationSwitch.isOn {
        NotificationModel.shared.scheduleNotification(at: selectedTime)
        
        // 설정한 시간 디버그 출력
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let timeString = dateFormatter.string(from: selectedTime)
        print("설정된 시간: \(timeString)")
        
        // 저장 확인 알림
        dateFormatter.dateFormat = "HH시 mm분"
        let confirmationTimeString = dateFormatter.string(from: selectedTime)
        let confirmationAlert = UIAlertController(title: nil, message: "매일 \(confirmationTimeString)에 알림이 설정되었습니다.", preferredStyle: .alert)
        confirmationAlert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
          // 페이지뷰 컨트롤러로 돌아가기
          self.navigationController?.popViewController(animated: true)
        })
        self.present(confirmationAlert, animated: true, completion: nil)
      } else {
        NotificationModel.shared.cancelNotification()
        self.navigationController?.popViewController(animated: true)
      }
    }
    let noAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
    alertController.addAction(yesAction)
    alertController.addAction(noAction)
    present(alertController, animated: true, completion: nil)
  }
  
  private func loadSettings() {
    let isNotificationOn = UserDefaults.standard.bool(forKey: "isNotificationOn")
    settingView.notificationSwitch.isOn = isNotificationOn
    if isNotificationOn {
      let hour = UserDefaults.standard.integer(forKey: "notificationHour")
      let minute = UserDefaults.standard.integer(forKey: "notificationMinute")
      
      var dateComponents = DateComponents()
      dateComponents.hour = hour
      dateComponents.minute = minute
      let calendar = Calendar.current
      if let notificationTime = calendar.date(from: dateComponents) {
        settingView.timePicker.date = notificationTime
      }
    }
  }
}
