//
//  BugFixModal.swift
//  Quantify
//
//  Created by David Hermann on 10.01.24.
//

import Foundation
import SwiftUI

struct PatchNotesView: View {
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Patch Notes")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Group {
                        Text("Version 1.0 (2024.0126.1)")
                            .font(.headline)
                            .padding(.top)
                            .underline()
                        Group {
                            Text("App interface:")
                                .fontWeight(.semibold)
                                .padding(.top)
                            Text("• Emote customization of categories")
                            Text("• New design of the categories due to adding emotes")
                        }
                        
                        Group {
                            Text("Bugfixes:")
                                .fontWeight(.semibold)
                                .padding(.top)
                            Text("• Fixed: Problem with showing Onboarding")
                        }
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("Version 1.0 (2024.0123.1)")
                            .font(.headline)
                            .padding(.top)
                            .underline()
                        Group {
                            Text("App interface:")
                                .fontWeight(.semibold)
                                .padding(.top)
                            Text("• Refactored the Onboarding view")
                        }
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("Version 1.0 (2024.0111.2)")
                            .font(.headline)
                            .padding(.top)
                            .underline()
                        Group {
                            Text("App interface:")
                                .fontWeight(.semibold)
                                .padding(.top)
                            Text("• Information about the category are available now if you swipe the category to the right.")
                        }

                        Group {
                            Text("Bugfixes:")
                                .fontWeight(.semibold)
                                .padding(.top)
                            Text("• Fixed: Problem with update view where the title isn't displayed correctly.")
                        }
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("Version 1.0 (2024.0111.1)")
                            .font(.headline)
                            .padding(.top)
                            .underline()
                        Group {
                            Text("App interface:")
                                .fontWeight(.semibold)
                                .padding(.top)
                            Text("• The patch notes are now available in the settings.")
                        }

                        Group {
                            Text("Bugfixes:")
                                .fontWeight(.semibold)
                                .padding(.top)
                            Text("• Fixed: Problem showing patch notes on first start after update.")
                            Text("• Fixed: Language typo in english at release date.")
                        }
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("Version 1.0 (2024.0111.0)")
                            .font(.headline)
                            .padding(.top)
                            .underline()
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

#Preview {
    PatchNotesView(isPresented: .constant(true))
}
