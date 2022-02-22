//
//  BackgroundView.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 17.02.2022.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [Color("GradientStart"),//.blue.opacity(0.3),
                                    Color("GradientEnd")],//.green.opacity(0.2)],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
