//
//  SettingsView.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 18.02.2022.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("appearance")
    var appearance: Appearance = .automatic
    
    @AppStorage("language")
    var language: Localization = .ru
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Form {
                    Section(header: Text("Appearance")) {
                        VStack(alignment: .trailing) {
                            Text("Language")
                                .foregroundColor(.gray)
                            Picker("PickLang", selection: $language) {
                                ForEach(Localization.allCases) { lang in
                                    Text(lang.name).tag(lang)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        
                        VStack(alignment: .trailing) {
                            Text("Theme")
                                .foregroundColor(.gray)
                            Picker("Pick", selection: $appearance) {
                                ForEach(Appearance.allCases) { appearance in
                                    Text(appearance.name).tag(appearance)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.top, 30)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}



