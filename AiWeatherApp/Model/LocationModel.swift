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
  
  override init() {
    super.init()
    locationManager.delegate = self
  }
  
  func requestAuthorization() {
    locationManager.requestWhenInUseAuthorization()
  }
  
  func requestLocation() {
    locationManager.requestLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.longitude
      print("위도: \(latitude), 경도: \(longitude)")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
    print("위치 정보를 가져올 수 없습니다: \(error)")
  }
}
