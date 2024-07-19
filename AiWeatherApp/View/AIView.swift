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
    imageView.layer.cornerRadius = 80
    return imageView
  }()
  let textView: UITextView = {
    let textView = UITextView()
    textView.text = "오늘의 서울 날씨는 맑음 입니다. 어떤 것을 하고싶으신가요?"
    textView.layer.borderColor = UIColor.black.cgColor
    textView.layer.borderWidth = 1
    textView.layer.cornerRadius = 5
    return textView
  }()
  lazy var button1: UIButton = {
    let button = UIButton()
    button.setTitle("Culture", for:.normal)
    return button
  }()
  lazy var button2: UIButton = {
    let button = UIButton()
    button.setTitle("Shopping", for:.normal)
    return button
  }()
  lazy var button3: UIButton = {
    let button = UIButton()
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
      textView,
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
    textView.snp.makeConstraints {
      $0.top.equalTo(longlong2.snp.bottom).offset(50)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(300)
      $0.height.equalTo(450)
    }
    loadingView.snp.makeConstraints {
      $0.top.equalTo(textView.snp.top)
      $0.bottom.equalTo(textView.snp.bottom)
      $0.leading.equalTo(textView.snp.leading)
      $0.trailing.equalTo(textView.snp.trailing)
    }
    buttonStackView.snp.makeConstraints {
      $0.bottom.equalTo(textView.snp.bottom)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(300)
      $0.height.equalTo(120)
    }
  }
}

