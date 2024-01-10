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
    
    @State private var showUpdateModal: Bool
    
    @State private var showingSettings = false
    
    @Environment(\.colorScheme) private var scheme
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    init() {
        _showUpdateModal = State(initialValue: isFirstLaunchAfterUpdate())
    }
    
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
            .sheet(isPresented: $showUpdateModal) {
                UpdateModalView(isPresented: $showUpdateModal)
            }
        }
        .preferredColorScheme(userTheme.colorScheme)
        
    }
    
    
    func addKategorie(name: String, counter: Int) {
        let neueKategorie = Category(name: name, counter: counter)
        dataManager.categories.append(neueKategorie)
    }
    
    func delete(at offsets: IndexSet) {
        dataManager.categories.remove(atOffsets: offsets)
    }
}

struct Category: Identifiable, Codable {
    var id = UUID()
    var name: String
    var anlegeDatum: Date = Date()
    var counter: Int = 0
    
    enum CodingKeys: CodingKey {
        case id, name, anlegeDatum, counter
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(anlegeDatum, forKey: .anlegeDatum)
        try container.encode(counter, forKey: .counter)
    }
    
    init(name: String, counter: Int = 0) {
        self.name = name
        self.counter = counter
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataManager())
    }
}

