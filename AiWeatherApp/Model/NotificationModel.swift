//
//  NotificationModel.swift
//  AiWeatherApp
//
//  Created by 김동현 on 7/17/24.
//

import Foundation
import UserNotifications

class NotificationModel: NSObject, UNUserNotificationCenterDelegate {
  static let shared = NotificationModel()
  
  override init() {
    super.init()
    UNUserNotificationCenter.current().delegate = self
  }
  
  func requestAuthorization(completion: @escaping (Bool) -> Void) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      completion(granted)
    }
  }
  
  func scheduleNotification(at date: Date) {
    let content = UNMutableNotificationContent()
    content.title = "알림"
    content.body = "앱을 열어 오늘의 날씨와 추천 활동을 알아보세요."
    content.sound = UNNotificationSound.default
    
    let calendar = Calendar.current
    let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
      if let error = error {
        print("Notification scheduling error: \(error)")
      } else {
        print("Notification scheduled for: hour: \(dateComponents.hour ?? 0) minute: \(dateComponents.minute ?? 0)")
        
        // 시간과 분 정보를 저장
        UserDefaults.standard.setValue(true, forKey: "isNotificationOn")
        UserDefaults.standard.setValue(dateComponents.hour, forKey: "notificationHour")
        UserDefaults.standard.setValue(dateComponents.minute, forKey: "notificationMinute")
        
        // 사용자 시간대로 날짜를 문자열로 변환하여 저장
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        let dateString = dateFormatter.string(from: date)
        
        UserDefaults.standard.set(true, forKey: "isNotificationOn")
        UserDefaults.standard.set(dateComponents.hour, forKey: "notificationHour")
        UserDefaults.standard.set(dateComponents.minute, forKey: "notificationMinute")
      }
    }
  }
  
  func cancelNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyNotification"])
    UserDefaults.standard.setValue(false, forKey: "isNotificationOn")
    UserDefaults.standard.removeObject(forKey: "notificationHour")
    UserDefaults.standard.removeObject(forKey: "notificationMinute")
  }
  
  // Foreground 알림 처리
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .sound, .badge])
  }
}
