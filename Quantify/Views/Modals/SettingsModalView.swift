//
//  SettingsModalView.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State private var changeTheme: Bool = false
    @State private var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    @State private var locale: Locale = .current
    
    @EnvironmentObject var languageManager: LanguageManager
    
    var scheme: ColorScheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Button("Change Theme") {
                    changeTheme.toggle()
                }
            }
            
            Section(header: Text("Language")) {
                Picker("Select Language", selection: $selectedLanguage) {
                    Text("Deutsch").tag("de")
                    Text("English").tag("en")
                    Text("Magyar").tag("hu")
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedLanguage) { _, newLanguage in
                    languageManager.setLanguage(to: newLanguage)
                }
            }
        }
        .navigationTitle("Settings")
        .preferredColorScheme(userTheme.colorScheme)
        .environment(\.locale, languageManager.locale)
        .sheet(isPresented: $changeTheme, content: {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
    }
}
