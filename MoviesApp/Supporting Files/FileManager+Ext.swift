//
//  FileManager+Ext.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 16.02.2022.
//

import Foundation

extension FileManager {
  static var documentURL: URL? {
    return Self.default.urls(
      for: .documentDirectory,
      in: .userDomainMask).first
  }
}
