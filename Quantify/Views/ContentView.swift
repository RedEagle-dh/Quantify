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
    
    @State private var showIntroModal: Bool
    
    
    init() {
        _showIntroModal = State(initialValue: checkFirstLaunch())
    }
    
    
    
    var body: some View {
        NavigationView {
            List {
                if dataManager.kategorien.isEmpty {
                    // Zentrierter Text für leere Kategorienliste
                    VStack {
                        Spacer() // Flexibler Spacer oben
                        Text("Keine Kategorien vorhanden")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer() // Flexibler Spacer unten
                    }
                    .frame(maxHeight: .infinity) // Ermöglicht vertikale Ausdehnung
                    .listRowBackground(Color.clear)
                } else {
                    // Liste der vorhandenen Kategorien
                    ForEach(dataManager.kategorien.indices, id: \.self) { index in
                        KategorieView(index: index)
                            .environmentObject(dataManager)
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                showingModal = true
            }) {
                Image(systemName: "plus")
            })
            .navigationBarTitle("Kategorien")
            .sheet(isPresented: $showingModal) {
                NewKategorieView(isPresented: $showingModal, onSave: addKategorie)
            }
            .sheet(isPresented: $showIntroModal) {
                IntroModalView(isPresented: $showIntroModal)
            }
        }
    }
    
    
    func addKategorie(name: String, counter: Int) {
        let neueKategorie = Kategorie(name: name, counter: counter)
        dataManager.kategorien.append(neueKategorie)
    }
    
    func delete(at offsets: IndexSet) {
        dataManager.kategorien.remove(atOffsets: offsets)
    }
}

func checkFirstLaunch() -> Bool {
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    if launchedBefore {
        return false
    } else {
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        return true
    }
}

struct KategorieView: View {
    @EnvironmentObject var dataManager: DataManager
    var index: Int
    
    var body: some View {
        HStack {
            Image(systemName: "minus.circle")
                .onTapGesture {
                    dataManager.decrementCounter(for: index)
                }
            Text(dataManager.kategorien[index].name)
            Spacer()
            Text("\(dataManager.kategorien[index].counter)")
            
            Image(systemName: "plus.circle")
                .onTapGesture {
                    dataManager.incrementCounter(for: index)
                }
        }
    }
}

struct NewKategorieView: View {
    @Binding var isPresented: Bool
    var onSave: (String, Int) -> Void
    @State private var name: String = ""
    @State private var counterText: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Kategoriename", text: $name)
                TextField("Counter", text: $counterText)
                    .keyboardType(.numberPad)
                    .onReceive(counterText.publisher.collect()) {
                        counterText = String($0.prefix(while: { "0123456789".contains($0) }))
                    }
            }
            .navigationBarTitle("Neue Kategorie")
            .navigationBarItems(leading: Button("Abbrechen") {
                isPresented = false
            }, trailing: Button("Speichern") {
                if let counter = Int(counterText) {
                    onSave(name, counter)
                }
                isPresented = false
            })
        }
    }
}


struct Kategorie: Identifiable, Codable {
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

struct IntroModalView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text(NSLocalizedString("welcomeKey", comment: "Welcome message"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                    .padding(.horizontal, 80)
                    .padding(.bottom, 40)
                FeatureView(icon: "hand.thumbsup", text: "Count whatever you want", desc: "This is a demo description of this app.")
                FeatureView(icon: "cloud", text: "iCloud saving coming soon", desc: "To store data in the cloud this is a demo description too.")
                FeatureView(icon: "text.book.closed", text: "Descriptions for categories coming soon", desc: "You can add your own descriptions for your own categories soon!")
                
                Spacer()
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Fortfahren")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

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




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataManager())
    }
}

