//
//  ProfileCardCell.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import UIKit
import SwiftUI

final class ProfileCardCell: UICollectionViewCell {

  static let identifier = "ProfileCardCell"

  lazy var card = UIHostingController(rootView: ProfileCard(developer: Developer()))

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(card.view)
    card.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      card.view.leadingAnchor.constraint(equalTo: leadingAnchor),
      card.view.trailingAnchor.constraint(equalTo: trailingAnchor),
      card.view.topAnchor.constraint(equalTo: topAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("unsupported initialize")
  }

  func configure(_ developer: Developer) {
    card.rootView = ProfileCard(developer: developer)
  }
}

struct ProfileCardCellRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<ProfileCardCellRP>) -> ProfileCardCell {
    ProfileCardCell()
  }

  func updateUIView(_ uiView: ProfileCardCell, context: Context) {

  }
}

struct ProfileCardCell_Previews: PreviewProvider {
  static var previews: some View {
    ProfileCardCellRP()
  }
}
