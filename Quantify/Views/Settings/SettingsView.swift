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
    
    @State private var showingAppInfo = false
    
    
    var scheme: ColorScheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        Form {
            Section(header: Text(NSLocalizedString("appearanceTitle", comment: "Text for the appearance category"))) {
                Button(NSLocalizedString("changeThemeButton", comment: "Text for the change theme button")) {
                    changeTheme.toggle()
                }
            }
            
            Section(header: Text(NSLocalizedString("generalSectionTitle", comment: "General settings section title"))) {
                NavigationLink(destination: AboutView()) {
                    Text(NSLocalizedString("appInfoButton", comment: "Button to show app info"))
                }
            }
            
            
            
        }
        .navigationTitle(NSLocalizedString("settingsTitle", comment: "Title for the settings page"))
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $changeTheme, content: {
            ChangeThemeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
        
    }
}


#Preview {
    SettingsView(scheme: .dark)
}
