//
//  CategoryView.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation
import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var languageManager: LanguageManager
    var category: Category
    
    var body: some View {
        HStack {
            Image(systemName: "minus.circle")
                .onTapGesture {
                    dataManager.decrementCounter(category: category)
                }
            Text(category.name)
            Spacer()
            Text("\(category.counter)")
            
            Image(systemName: "plus.circle")
                .onTapGesture {
                    dataManager.incrementCounter(category: category)
                }
        }
        .environment(\.locale, languageManager.locale)
    }
}
