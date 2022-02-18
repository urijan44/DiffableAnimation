//
//  DeveloperModel.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import Foundation

final class Developer: Hashable {
  static func == (lhs: Developer, rhs: Developer) -> Bool {
    lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  enum Language: String, Hashable, CaseIterable {
    case swift
    case java
    case cpp
    case c
    case dart
    case go
    case kotlin
    case javascript
    case sql
    case html
    case css
    case python
    case csharp
    case php
    case objectiveC
  }

  enum Major: String {
    case iOS
    case backend
    case frontend
    case android
    case unity
    case none
  }

  var id = UUID().uuidString
  var name: String
  var major: Major
  var language: [Language]
  var carrer: String
  var searcable: Bool = true

  init(name: String = "unknown", major: Major = .none, language: [Language] = [], carrer: String = "무소속") {
    self.name = name
    self.major = major
    self.language = language
    self.carrer = carrer
  }

  func languageString() -> [String] {
    var arr: [String] = []
    language.forEach { lang in
      arr.append(lang.rawValue)
    }

    return arr
  }
}
