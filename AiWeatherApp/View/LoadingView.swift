//
//  LoadingView.swift
//  AiWeatherApp
//
//  Created by pc on 7/19/24.
//

import UIKit
import SnapKit

final class LoadingView: UIView {
  private let backgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
    view.layer.cornerRadius = 5
    return view
  }()
  private let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    return activityIndicatorView
  }()
  
  var isLoading = false {
    didSet {
      self.isHidden = !self.isLoading
      self.isLoading ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func configureUI() {
    [
      backgroundView,
      activityIndicatorView
    ].forEach { self.addSubview($0) }
  }
  
  func setConstraints() {
    backgroundView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    activityIndicatorView.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
