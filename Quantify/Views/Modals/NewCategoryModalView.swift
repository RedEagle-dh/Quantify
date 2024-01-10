//
//  NewCategoryModalView.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation
import SwiftUI

struct NewCategoryModalView: View {
    @Binding var isPresented: Bool
    var onSave: (String, Int) -> Void
    @State private var name: String = ""
    @State private var counterText: String = "0"
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        NavigationView {
            Form {
                TextField(NSLocalizedString("newCategoryInputName", comment: "Input field placeholder for name"), text: $name)
                TextField(NSLocalizedString("newCategoryInputCounter", comment: "Input field placeholder for counter"), text: $counterText)
                    .keyboardType(.numberPad)
                    .onReceive(counterText.publisher.collect()) {
                        counterText = String($0.prefix(while: { "0123456789".contains($0) }))
                    }
            }
            .navigationBarTitle(NSLocalizedString("newCategoryTitle", comment: "New category modal title"))
            .navigationBarItems(leading: Button(NSLocalizedString("newCategoryCancel", comment: "Cancel saving new category")) {
                
                isPresented = false
            }, trailing: Button(NSLocalizedString("newCategorySave", comment: "Save new category")) {
                if let counter = Int(counterText) {
                    onSave(name, counter)
                }
                isPresented = false
            })
        }.preferredColorScheme(userTheme.colorScheme)
    }
}
