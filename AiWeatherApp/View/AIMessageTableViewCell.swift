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
    imageView.layer.borderColor = UIColor(.black).cgColor
    imageView.layer.borderWidth = 1
    imageView.layer.cornerRadius = 25
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let Message: UILabel = {
    let label = UILabel()
    label.text = ""
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
      Message,
    ].forEach { self.addSubview($0) }
  }
  private func setConstraints() {
    longlong2.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.leading.equalTo(contentView).offset(10)
      $0.width.height.equalTo(50)
    }
    Message.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.leading.equalTo(longlong2.snp.trailing).offset(10)
    }
   
  }
}
