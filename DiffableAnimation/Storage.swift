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
    Developer(name: "이호승", major: .iOS, language: [.swift], carrer: "메밀컴퍼니"),
    Developer(name: "박연배", major: .iOS, language: [.swift], carrer: "장발컴퍼니"),
    Developer(name: "최광호", major: .android, language: [.kotlin, .java], carrer: "(주)광어"),
    Developer(name: "길아현", major: .frontend, language: [.javascript, .html, .css], carrer: "치타주식회사"),
    Developer(name: "이상훈", major: .backend, language: [.java, .kotlin], carrer: "숨덕어소시에이트"),
    Developer(name: "JACK", major: .iOS, language: [.swift, .objectiveC], carrer: "메모리스"),
    Developer(name: "윤여종", major: .android, language: [.java, .kotlin], carrer: "KOKOJONG-Industry"),
    Developer(name: "김혜진", major: .backend, language: [.python, .csharp], carrer: "두목회"),
    Developer(name: "조동현", major: .unity, language: [.csharp], carrer: "LTD. Immediate"),
    Developer(name: "황찬호", major: .backend, language: [.c, .java], carrer: "Hungry연합"),
    Developer(name: "신동원", major: .android, language: [.kotlin, .java], carrer: "사조참치"),
    Developer(name: "김영민", major: .iOS, language: [.swift, .javascript], carrer: "NotZam"),
  ]

  var filteredDevelopers: [Developer] {
    developers.filter { developer in
      return developer.searcable == true
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
    }
  }
}


