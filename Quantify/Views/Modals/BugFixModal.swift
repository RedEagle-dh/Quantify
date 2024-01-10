//
//  BugFixModal.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation
import SwiftUI

struct BugFixesModalView: View {
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Update-Details")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Version 1.1.0 (10. January 2024)")
                        .font(.headline)
                        .padding(.top)

                    Group {
                        Text("App interface:")
                            .fontWeight(.semibold)
                            .padding(.top)
                        Text("• Dark and lightmode are available now.")
                        Text("• Created this screen for update information.")
                        Text("• Created settings page with app information and appearance changes.")
                        Text("• We now support German, English and Hungarian.")
                    }

                    Group {
                        Text("Bugfixes:")
                            .fontWeight(.semibold)
                            .padding(.top)
                        Text("• Fixed: Problem with creating a category without a given counter.")
                        Text("• Fixed: App crashes when category gets deleted.")
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Update-Details", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
