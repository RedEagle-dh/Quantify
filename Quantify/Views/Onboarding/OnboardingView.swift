//
//  UpdateModalView.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation
import SwiftUI


struct FeatureView: View {
    var icon: String
    var text: String
    var desc: String
    
    var body: some View {
        HStack(alignment: .top) { // Hier wird die Ausrichtung auf .top gesetzt
            Image(systemName: icon)
                .foregroundColor(.blue)
                .imageScale(.large)
                .font(.system(size: 30))
                .frame(width: 65, height: 75)
            
            VStack(alignment: .leading) { // Ausrichtung des VStacks auf .leading
                Text(text)
                    .font(.headline)
                Text(desc)
                    .font(.subheadline) // Optional: eine kleinere Schriftgröße für die Beschreibung
                    .foregroundColor(.gray) // Optional: Farbänderung für die Beschreibung
            }
            .padding(.leading, 5) // Etwas Abstand zwischen Icon und Text
            
            Spacer()
        }
    }
}


struct OnboardingView: View {
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    @Binding var isPresented: Bool
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Text(NSLocalizedString("updateModalTitle", comment: "Welcome message"))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                        .padding(.bottom, 40)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                
                FeatureView(icon: NSLocalizedString("featureOneIcon", comment: "Icon of first feature"),
                            text: NSLocalizedString("featureOneTitle", comment: "Title of first feature"),
                            desc: NSLocalizedString("featureOneDescription", comment: "Description of first feature")
                )
                FeatureView(icon: NSLocalizedString("featureTwoIcon", comment: "Icon of second feature"),
                            text: NSLocalizedString("featureTwoTitle", comment: "Title of second feature"),
                            desc: NSLocalizedString("featureTwoDescription", comment: "Description of second feature")
                )
                FeatureView(icon: NSLocalizedString("featureThreeIcon", comment: "Icon of third feature"),
                            text: NSLocalizedString("featureThreeTitle", comment: "Title of third feature"),
                            desc: NSLocalizedString("featureThreeDescription", comment: "Description of third feature")
                )

                
                Spacer()
                VStack {
                    Image(.dataPrivacyIcon)
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                Group {
                                    Text(NSLocalizedString("privacyText", comment: "Text for privacy"))
                                        .foregroundStyle(.secondary)
                                }
                                .multilineTextAlignment(.center)
                                .font(.system(size: 10))
                                .padding(.bottom, 24)
                                .padding(.top, 4)
                    Button(action: {
                        isPresented = false
                    }) {
                        Text(NSLocalizedString("updateModalButton", comment: "ContinueButton"))
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
            }
            .padding()
        }
        .preferredColorScheme(userTheme.colorScheme)
    }
}


#Preview {
    OnboardingView(isPresented: .constant(true))
}
