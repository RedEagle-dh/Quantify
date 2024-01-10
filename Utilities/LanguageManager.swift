//
//  LanguageManager.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation


class LanguageManager: ObservableObject {
    @Published var locale: Locale

    init(locale: Locale = .current) {
        self.locale = locale
    }

    func setLanguage(to languageCode: String) {
        locale = Locale(identifier: languageCode)
    }
}
