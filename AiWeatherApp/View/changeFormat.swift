//
//  changeFormat.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/20/24.
//

import Foundation

class changeFormat {
  
  static let shared = changeFormat()
  
  func extractDayAndTime(from dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    
    guard let date = dateFormatter.date(from: dateString) else { return nil }
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "EEEE HH시"
    outputFormatter.locale = Locale(identifier: "ko_KR")
    let formattedString = outputFormatter.string(from: date)
    return formattedString
  }
  
  func changeString(_ value: Double) -> String? {
    let numberFormatter = NumberFormatter()
    numberFormatter.maximumFractionDigits = 1
    numberFormatter.minimumFractionDigits = 1
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: value))
  }
  
  func formatDateToString(_ date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = TimeZone.current
      return dateFormatter.string(from: date)
  }
  
  func formatTimeToString(_ date: Date, format: String = "HH시 mm분") -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = TimeZone.current
      return dateFormatter.string(from: date)
  }
}
