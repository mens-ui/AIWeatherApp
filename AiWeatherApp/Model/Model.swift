//
//  Model.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import Foundation

struct Data {
  let urlQueryItems: [URLQueryItem] = [
    URLQueryItem(name: "lat", value: "37.5"),
    URLQueryItem(name: "lon", value: "126.9"),
    URLQueryItem(name: "appid", value: "cec8dc376cea68811d800a55218dbeed"),
    URLQueryItem(name: "units", value: "metric")
  ]
}

