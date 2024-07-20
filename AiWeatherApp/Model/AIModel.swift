//
//  AIAnswer.swift
//  AiWeatherApp
//
//  Created by pc on 7/18/24.
//

import Foundation

struct Categories: Codable {
  let culture: [Item]
  let shopping: [Item]
  let food: [Item]
  
  subscript(selected: String) ->[Item]? {
    switch selected {
    case "culture":
      return culture
    case "shoping":
      return shopping
    case "food":
      return food
    default:
      return nil
    }
  }
}

struct Item: Codable {
  let name: String
  let description: String
}
