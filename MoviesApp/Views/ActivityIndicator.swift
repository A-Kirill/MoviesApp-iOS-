//
//  ActivityIndicator.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 15.02.2022.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style = .medium
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
