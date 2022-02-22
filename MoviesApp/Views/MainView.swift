//
//  MainView.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 17.02.2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            MainContentView()
                .tabItem {
                    Label("List", systemImage: "film")
                }
            
            FavoriteView()
                .tabItem {
                    Label("Favorites", systemImage: "bookmark")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            
        }
        .accentColor(Color("TabBarSelected"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MoviesViewModel())
    }
}
