//
//  String+Ext.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 16.02.2022.
//

import Foundation

extension String {
    func formateDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMM yyyy"
        dateFormatterPrint.locale = Locale(identifier: "ru")
        let date = dateFormatterGet.date(from: self) ?? Date.now
        return dateFormatterPrint.string(from: date)
    }
}
