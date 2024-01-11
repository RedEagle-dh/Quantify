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

class AppUpdateManager {
    static let shared = AppUpdateManager()
    private var hasCheckedFirstLaunch: Bool = false

    func isFirstLaunchAfterUpdate() -> Bool {
        if hasCheckedFirstLaunch {
            return false
        }

        let currentVersion = getCurrentAppVersion()
        let currentBuild = getCurrentBuildNumber()

        let previousVersion = UserDefaults.standard.string(forKey: "lastVersion")
        let previousBuild = UserDefaults.standard.string(forKey: "lastBuild")

        if previousVersion != currentVersion || previousBuild != currentBuild {
            UserDefaults.standard.set(currentVersion, forKey: "lastVersion")
            UserDefaults.standard.set(currentBuild, forKey: "lastBuild")
            hasCheckedFirstLaunch = true
            return true
        }

        hasCheckedFirstLaunch = true
        return false
    }
}


