//
//  ViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

class MainViewController: UIViewController {
  
  var mainView: MainView!
  
  override func loadView() {
    self.view = mainView(frame: UIScreen.main.bounds)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .brown
  }
}

