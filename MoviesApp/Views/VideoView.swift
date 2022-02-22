//
//  VideoView.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 14.02.2022.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.accessibilityIdentifier = "VideoView"
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let videoURL = URL(string: url) else { return }
        uiView.isOpaque = false
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: videoURL))
    }
    
}

