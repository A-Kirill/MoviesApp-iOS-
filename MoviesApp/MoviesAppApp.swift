//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 09.02.2022.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    @StateObject var viewModel = MoviesViewModel()
    @StateObject var store = MovieStore()
    @AppStorage("appearance") var appearance: Appearance = .automatic
    @AppStorage("language") var language: Localization = .ru
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .environmentObject(store)
                .environment(\.locale, Locale(identifier: language.rawValue))
                .preferredColorScheme(appearance.getColorScheme())
                .onAppear {
                    print(FileManager.documentURL ?? "")
                }
        }
    }
}
