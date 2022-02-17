//
//  CardDetailView.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import SwiftUI

struct CardDetailView: View {
  let developer: Developer
  var body: some View {
    ZStack(alignment: .bottom) {
      RoundedRectangle(cornerRadius: 8)
        .foregroundColor(Storage.signaturColor(major: developer.major).opacity(0.8))
        .clipped()
        .overlay(
          ZStack(alignment: .top) {
            Rectangle()
              .foregroundColor(.white)
              .padding(.top, 200)
            VStack(alignment: .center, spacing: 6) {
              Image("face")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 120)
                .clipShape(Circle())
                .overlay {
                  Circle().stroke(.white, lineWidth: 2)
                }
                .shadow(radius: 2)
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
            .offset(x: 0, y: 150)
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
          HStack {
            Text("Call")
              .font(.system(size: 14))
              .foregroundColor(.white)

            Image(systemName: "phone.fill")
              .resizable()
              .frame(width: 18, height: 18)
              .foregroundColor(.white)

          }
        )
        .padding()
    }
  }
}

struct CardDetailView_Previews: PreviewProvider {
  static var previews: some View {
    CardDetailView(developer: Storage.shared.developers[0])
  }
}
