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

func getCurrentBuildNumber() -> String {
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
}

func isFirstLaunchAfterUpdate() -> Bool {
    let currentVersion = getCurrentAppVersion()
    let currentBuild = getCurrentBuildNumber()
    
    let previousVersion = UserDefaults.standard.string(forKey: "lastVersion")
    let previousBuild = UserDefaults.standard.string(forKey: "lastBuild")

    if previousVersion != currentVersion || previousBuild != currentBuild {
        UserDefaults.standard.set(currentVersion, forKey: "lastVersion")
        UserDefaults.standard.set(currentBuild, forKey: "lastBuild")
        return true
    }
    return false
}



