//
//  AppInfoView.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation
import SwiftUI

struct AppInfoView: View {
    
    var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    }
    
    var buildVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
    }
    
    var body: some View {
        List {
                HStack {
                    Text(NSLocalizedString("appVersion", comment: "Title of app version"))
                    Spacer()
                    Text(appVersion)
                }
                
                HStack {
                    Text(NSLocalizedString("appBuildVersion", comment: "Title of build version"))
                    Spacer()
                    Text(buildVersion)
                }
                
                HStack {
                    Text(NSLocalizedString("releaseDateString", comment: "Title of release date"))
                    Spacer()
                    Text(NSLocalizedString("releaseDate", comment: "Date of release"))
                }
        }.padding(.top, 10)
            .navigationTitle(NSLocalizedString("appInfoTitle", comment: "Title of info page"))
    }
}
