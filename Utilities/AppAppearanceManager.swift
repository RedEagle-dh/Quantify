//
//  AppAppearanceManager.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation


func fetchDarkMode() -> Bool {
    return UserDefaults.standard.bool(forKey: "DARKMODE_KEY")
}
