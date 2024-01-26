//
//  ContentView.swift
//  Counting
//
//  Created by David Hermann on 06.01.24.
//



import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State private var showingModal = false
    
    @State private var showOnboardingView = false
    
    @State private var showingSettings = false
    
    @Environment(\.colorScheme) private var scheme
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                
                List {
                    if dataManager.categories.isEmpty {
                        // Zentrierter Text für leere Kategorienliste
                        VStack {
                            Spacer() // Flexibler Spacer oben
                            Text(NSLocalizedString("noCategoriesFound", comment: "No categories found"))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer() // Flexibler Spacer unten
                        }
                        .frame(maxHeight: .infinity) // Ermöglicht vertikale Ausdehnung
                        .listRowBackground(Color.clear)
                    } else {
                        // Liste der vorhandenen Kategorien
                        ForEach(dataManager.categories, id: \.id) { category in
                            CategoryView(category: category)
                                .environmentObject(dataManager)
                        }
                        .onDelete(perform: delete)
                    }
                }.onAppear {
                    showOnboardingView = AppUpdateManager.shared.isFirstLaunchAfterUpdate()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showingModal = true
                        }) {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .padding()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .navigationDestination(isPresented: $showingSettings) {
                SettingsView(scheme: scheme)
            }
            .navigationBarTitle(NSLocalizedString("mainTitle", comment: "Title for categories"))
            .sheet(isPresented: $showingModal) {
                NewCategoryModalView(isPresented: $showingModal, onSave: addKategorie)
            }
            .sheet(isPresented: $showOnboardingView) {
                OnboardingView(isPresented: $showOnboardingView)
            }
        }
        .preferredColorScheme(userTheme.colorScheme)
        
    }
    
    
    func addKategorie(name: String, counter: Int, emoji: String) {
        let neueKategorie = Category(name: name, counter: counter, emoji: emoji)
        dataManager.categories.append(neueKategorie)
    }
    
    func delete(at offsets: IndexSet) {
        dataManager.categories.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataManager())
    }
}

