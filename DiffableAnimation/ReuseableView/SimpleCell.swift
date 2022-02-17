//
//  SimpleCell.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import UIKit
final class SimpleCell: UITableViewCell {

  static let reuseIdentifier = "SimpleCell"

  lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var majorLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    createView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  func cellConfigure(developer: Developer) {
    nameLabel.text = developer.name
    majorLabel.text = developer.major.rawValue
  }

  private func createView() {
    addSubview(nameLabel)
    addSubview(majorLabel)
    configureLayout()
  }

  private func configureLayout() {
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      majorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      majorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
