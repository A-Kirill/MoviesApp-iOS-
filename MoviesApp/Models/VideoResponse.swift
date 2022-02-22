//
//  VideoResponse.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 14.02.2022.
//

import Foundation

struct VideoResponse: Codable {
    let items: [Video]
    var supported: [Video] {
        items.filter{ !$0.url.contains("mds.yandex.net") }
    }
}

// MARK: - Video
struct Video: Codable, Identifiable {
    var id = UUID()
    let url: String
    let name: String
    let site: String
    
    enum CodingKeys: String, CodingKey {
        case url, name, site
    }
}
