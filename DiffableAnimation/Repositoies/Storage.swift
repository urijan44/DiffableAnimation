//
//  Storage.swift
//  DiffableAnimation
//
//  Created by hoseung Lee on 2022/02/17.
//

import Foundation
import SwiftUI

class Storage {

  static let shared = Storage()

  private init() {}

  var developers: [Developer] = [
    Developer(name: "Henry", major: .iOS, language: [.swift], carrer: "메밀컴퍼니"),
    Developer(name: "Paul", major: .iOS, language: [.swift], carrer: "장발컴퍼니"),
    Developer(name: "Kwang", major: .android, language: [.kotlin, .java], carrer: "(주)광어"),
    Developer(name: "KA", major: .frontend, language: [.javascript, .html, .css], carrer: "치타주식회사"),
    Developer(name: "Smith", major: .backend, language: [.java, .kotlin], carrer: "숨덕어소시에이트"),
    Developer(name: "JACK", major: .iOS, language: [.swift, .objectiveC], carrer: "메모리스"),
    Developer(name: "Marco", major: .android, language: [.java, .kotlin], carrer: "KOKOJONG-Industry"),
    Developer(name: "Conelly", major: .backend, language: [.python, .csharp], carrer: "두목회"),
    Developer(name: "J.K.", major: .unity, language: [.csharp], carrer: "LTD. Immediate"),
    Developer(name: "Hwang", major: .backend, language: [.c, .java], carrer: "Hungry연합"),
    Developer(name: "Dud", major: .android, language: [.kotlin, .java], carrer: "사조참치"),
    Developer(name: "Min", major: .iOS, language: [.swift, .javascript], carrer: "NotZam"),
  ]

  var filteredDevelopers: [Developer] {
    developers.filter { developer in
      return developer.searcable == true
    }
  }

  var sortedDevelopers: [Developer] {
    developers.sorted { lhs, rhs in
      lhs.major.rawValue < rhs.major.rawValue
    }
  }

  func filteredByMajor(major: Developer.Major) -> [Developer] {
    if major == .none {
      return developers
    } else {
      return developers.filter { developer in
        developer.major == major
      }
    }
  }

  static func signaturColor(major: Developer.Major) -> Color {
    switch major {
      case .iOS:
        return Color("Swift")
      case .backend:
        return Color("Java")
      case .frontend:
        return Color("Javascript")
      case .android:
        return Color("Kotlin")
      case .unity:
        return Color("Unity")
      case .none:
        return .black
    }
  }

  func deleteItem(_ developer: Developer) {
    guard let index = developers.firstIndex(of: developer) else { return }
    developers.remove(at: index)
  }
}


