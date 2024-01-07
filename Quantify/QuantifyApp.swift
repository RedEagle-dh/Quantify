//
//  QuantifyApp.swift
//  Quantify
//
//  Created by David Hermann on 06.01.24.
//

import SwiftUI

class DataManager: ObservableObject {
    @Published var kategorien: [Kategorie] = []
    
    init() {
        loadFromUserDefaults()
    }
    
    func saveToUserDefaults() {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(kategorien) {
            let jsonString = String(data: encoded, encoding: .utf8)
            
            UserDefaults.standard.set(jsonString, forKey: "KATEGORIEN_KEY")
        }
    }
    
    
    func loadFromUserDefaults() {
        if let jsonString = UserDefaults.standard.string(forKey: "KATEGORIEN_KEY"),
           let jsonData = jsonString.data(using: .utf8) {
            let decoder = JSONDecoder()
            if let decodedKategorien = try? decoder.decode([Kategorie].self, from: jsonData) {
                kategorien = decodedKategorien
            }
        }
    }
    
    func incrementCounter(for index: Int) {
        print("Increment")
        if kategorien.indices.contains(index) {
            kategorien[index].counter += 1
        }
    }
    
    func decrementCounter(for index: Int) {
        print("Decrement")
        if kategorien.indices.contains(index), kategorien[index].counter > 0 {
            kategorien[index].counter -= 1
        }
    }
}

@main
struct CountingApp: App {
    @StateObject var dataManager = DataManager()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
                .onChange(of: scenePhase) { oldPhase, newPhase in
                    switch newPhase {
                    case .active:
                        dataManager.loadFromUserDefaults()
                    case .background:
                        dataManager.saveToUserDefaults()
                    default:
                        break
                    }
                }
        }
    }
}



