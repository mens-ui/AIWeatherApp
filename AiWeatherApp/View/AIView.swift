//
//  MainView.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit
import SnapKit

class AIView: UIView {
  let loadingView: LoadingView = {
    let view = LoadingView()
    view.isHidden = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let longlong2: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .gray
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 64
    return imageView
  }()

  lazy var aiMessageTableView: UITableView = {
    let tableView = UITableView()
    tableView.layer.borderColor = UIColor.black.cgColor
    tableView.layer.borderWidth = 1
    tableView.layer.cornerRadius = 5
    tableView.rowHeight = UITableView.automaticDimension
    return tableView
  }()
  lazy var button1: AnimationButton = {
    let button = AnimationButton()
    button.setTitle("Culture", for:.normal)
    return button
  }()
  lazy var button2: AnimationButton = {
    let button = AnimationButton()
    button.setTitle("Shopping", for:.normal)
    return button
  }()
  lazy var button3: AnimationButton = {
    let button = AnimationButton()
    button.setTitle("Food", for:.normal)
    return button
  }()
  
  lazy var buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.backgroundColor = .systemBackground
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    [ 
      longlong2,
      aiMessageTableView,
      buttonStackView,
      loadingView
    ].forEach { self.addSubview($0)}
    [
      button1,
      button2,
      button3].forEach {
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        buttonStackView.addArrangedSubview($0)
      }
  }
  
  func setConstraints() {
    longlong2.snp.makeConstraints {
      $0.top.equalToSuperview().offset(80)
      $0.centerX.equalToSuperview()
      $0.height.width.equalTo(160)
    }
    aiMessageTableView.snp.makeConstraints {
      $0.top.equalTo(longlong2.snp.bottom).offset(50)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(300)
      $0.height.equalTo(450)
    }
    loadingView.snp.makeConstraints {
      $0.top.equalTo(aiMessageTableView.snp.top)
      $0.bottom.equalTo(aiMessageTableView.snp.bottom)
      $0.leading.equalTo(aiMessageTableView.snp.leading)
      $0.trailing.equalTo(aiMessageTableView.snp.trailing)
    }
    buttonStackView.snp.makeConstraints {
      $0.bottom.equalTo(aiMessageTableView.snp.bottom)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(300)
      $0.height.equalTo(120)
    }
  }
}

