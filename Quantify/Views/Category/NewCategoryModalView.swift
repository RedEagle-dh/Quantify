//
//  NewCategoryModalView.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation
import SwiftUI
import MCEmojiPicker

struct NewCategoryModalView: View {
    @Binding var isPresented: Bool
    var onSave: (String, Int, String) -> Void
    @State private var name: String = ""
    @State private var counterText: String = "0"
    @State private var emoji: String = "🙂"
    @State private var isEmojiPickerPresented = false
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Button(action: {
                        isEmojiPickerPresented.toggle()
                    }) {
                        Text(emoji)
                            .font(.system(size: 40)) // Erhöhte Schriftgröße
                            .frame(width: 50, height: 50) // Größerer Frame
                            .background(Circle().fill(backgroundForCurrentMode))
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                    }
                    .emojiPicker(
                        isPresented: $isEmojiPickerPresented,
                        selectedEmoji: $emoji
                    )
                    VStack {
                        TextField(NSLocalizedString("newCategoryInputName", comment: "Input field placeholder for name"), text: $name)
                        Divider()
                        TextField(NSLocalizedString("newCategoryInputCounter", comment: "Input field placeholder for counter"), text: $counterText)
                            .keyboardType(.numberPad)
                            .onReceive(counterText.publisher.collect()) {
                                counterText = String($0.prefix(while: { "0123456789".contains($0) }))
                            }
                    }
                }
                
                
            }
            .navigationBarTitle(NSLocalizedString("newCategoryTitle", comment: "New category modal title"))
            .navigationBarItems(leading: Button(NSLocalizedString("newCategoryCancel", comment: "Cancel saving new category")) {
                
                isPresented = false
            }, trailing: Button(NSLocalizedString("newCategorySave", comment: "Save new category")) {
                if let counter = Int(counterText) {
                    onSave(name, counter, emoji)
                }
                isPresented = false
            })
        }.preferredColorScheme(userTheme.colorScheme)
    }
    
    private var backgroundForCurrentMode: Color {
        userTheme == .dark ? Color(white: 0.2) : Color(white: 0.9)
    }
}
