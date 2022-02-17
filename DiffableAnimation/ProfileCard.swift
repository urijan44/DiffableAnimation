//
//  ProfileCard.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import SwiftUI

struct ProfileCard: View {

  let developer: Developer
  var body: some View {
    
    ZStack(alignment: .bottom) {
      RoundedRectangle(cornerRadius: 8)
        .frame(width: 140, height: 240)
        .foregroundColor(Storage.signaturColor(major: developer.major).opacity(0.8))
        .clipped()
        .overlay(
          ZStack(alignment: .top) {
            Rectangle()
              .foregroundColor(.white)
              .padding(.top, 50)
            VStack(alignment: .center, spacing: 6) {
              Text(developer.name)
                .font(.body)
                .padding()
              Text(developer.major.rawValue.capitalized)
                .font(.body)
                .foregroundColor(Storage.signaturColor(major: developer.major))
              Text(developer.carrer)
                .font(.system(size: 14))
                .padding(.top, 16)
              HStack {
                ForEach(developer.languageString(), id: \.self) {
                  Text($0.capitalized)
                    .lineLimit(1)
                }
              }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 16)
          }
            .clipShape(RoundedRectangle(cornerRadius: 8))
        )
        .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
      Capsule(style: .circular)
        .frame(width: 100, height: 33)
        .foregroundColor(Storage.signaturColor(major: developer.major))
        .overlay(
          Text("View Profile")
            .font(.system(size: 14))
            .foregroundColor(.white)
        )
        .padding()
    }
  }
}

struct ProfileCard_Previews: PreviewProvider {

  static var previews: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyVGrid(columns: [
        .init(.fixed(140), spacing: 5, alignment: .center),
          .init(.fixed(140), spacing: 5, alignment: .center),
          .init(.fixed(140), spacing: 5, alignment: .center)
      ]) {
        ProfileCard(developer: Storage.shared.developers[0])
        ProfileCard(developer: Storage.shared.developers[1])
        ProfileCard(developer: Storage.shared.developers[2])
        ProfileCard(developer: Storage.shared.developers[3])
        ProfileCard(developer: Storage.shared.developers[4])
        ProfileCard(developer: Storage.shared.developers[5])
        ProfileCard(developer: Storage.shared.developers[6])
        ProfileCard(developer: Storage.shared.developers[7])
        ProfileCard(developer: Storage.shared.developers[8])
      }
    }
  }
}
