//
//  AIMessageTableViewCell.swift
//  AiWeatherApp
//
//  Created by pc on 7/20/24.
//

import UIKit
import SnapKit

class AIMessageTableViewCell: UITableViewCell {
  let longlong2: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 12
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let message: UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = .systemFont(ofSize: 15)
    label.numberOfLines = 0
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func configureUI() {
    [
      longlong2,
      message,
    ].forEach { self.addSubview($0) }
  }
  private func setConstraints() {
    longlong2.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(10)
      $0.width.height.equalTo(30)
    }
    message.snp.makeConstraints {
      $0.leading.equalTo(longlong2.snp.trailing).offset(10)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalToSuperview().offset(10)
      $0.bottom.equalToSuperview().offset(-10)
    }
  }
  func configureCell(aimessage: String, imageName: String?) {
    message.text = aimessage
    if let imageName = imageName {
      longlong2.image = UIImage(named: imageName)
    }
  }
}
