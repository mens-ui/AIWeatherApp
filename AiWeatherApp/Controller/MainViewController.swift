//
//  ViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

import Alamofire

class MainViewController: UIViewController {
  
  var mainView: MainView!
  
  override func loadView() {
    self.view = MainView(frame: UIScreen.main.bounds)
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
  }
}

