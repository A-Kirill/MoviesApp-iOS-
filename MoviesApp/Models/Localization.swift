//
//  Localization.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 18.02.2022.
//

import Foundation

enum Localization: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case ru
    case en
    
    var name: String {
      switch self {
      case .ru: return "ru"
      case .en: return "en"
      }
    }
}
