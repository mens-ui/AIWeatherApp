//
//  LocationModel.swift
//  AiWeatherApp
//
//  Created by 김동현 on 7/17/24.
//

import Foundation
import CoreLocation

class LocationModel: NSObject, CLLocationManagerDelegate {
  static let shared = LocationModel()
  private let locationManager = CLLocationManager()
  var locationUpdateHandler: (() -> Void)?
  
  override init() {
    super.init()
    locationManager.delegate = self
  }
  
  func requestAuthorization() {
    locationManager.requestWhenInUseAuthorization()
  }
  
  func requestLocation() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager.requestLocation()
    } else {
      print("위치 서비스가 비활성화되어 있습니다.")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      requestLocation()
    case .denied, .restricted:
      print("위치 권한이 거부되었습니다.")
    default:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.longitude
      
      // 위도와 경도 값을 UserDefaults에 저장
      UserDefaults.standard.setValue(latitude, forKey: "latitude")
      UserDefaults.standard.setValue(longitude, forKey: "longitude")
      
      print("위도: \(latitude), 경도: \(longitude)")
      
      // 위치 업데이트 핸들러 호출
      locationUpdateHandler?()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
    print("위치 정보를 가져올 수 없습니다: \(error)")
  }
}
