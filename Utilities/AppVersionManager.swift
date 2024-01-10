//
//  AppVersionManager.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation


func getCurrentAppVersion() -> String {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
}


func isFirstLaunchAfterUpdate() -> Bool {
    let currentVersion = getCurrentAppVersion()
    let previousVersion = UserDefaults.standard.string(forKey: "lastVersion")
    
    if previousVersion == nil || previousVersion != currentVersion {
        UserDefaults.standard.set(currentVersion, forKey: "lastVersion")
        return true
    }
    return false
}


