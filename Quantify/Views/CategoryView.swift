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
    @State var showingInfoModal: Bool = false
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
        .swipeActions(edge: .leading) {
            Button(action: {
                showingInfoModal = true
            }) {
                Label("Info", systemImage: "info.circle")
            }
        }
        .sheet(isPresented: $showingInfoModal) {
            CategoryInfoModalView(isPresented: $showingInfoModal, category: category)
        }
    }
}

struct Category: Identifiable, Codable {
    var id = UUID()
    var name: String
    var anlegeDatum: Date = Date()
    var counter: Int = 0
    var lastModifiedDate: Date?
    
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


struct CategoryInfoModalView: View {
    @Environment(\.colorScheme) private var scheme
    @Binding var isPresented: Bool
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    var category: Category

    var body: some View {
        NavigationView {
            List {
                Section(NSLocalizedString("generalSectionTitle", comment: "General settings section title")) {
                    
                    HStack {
                        Text(NSLocalizedString("nameLabel", comment: "Label for name"))
                        Spacer()
                        Text("\(category.name)")
                    }
                    
                    HStack {
                        Text(NSLocalizedString("currentCounterLabel", comment: "Label for current counter"))
                        Spacer()
                        Text("\(category.counter)")
                    }
                    
                    HStack {
                        Text(NSLocalizedString("creationDateLabel", comment: "Label for creation date"))
                        Spacer()
                        Text("\(category.anlegeDatum, formatter: dateFormatter)")
                    }
                    
                    if let lastModified = category.lastModifiedDate {
                        HStack {
                            Text(NSLocalizedString("lastModifiedDateLabel", comment: "Label for last modified date"))
                            Spacer()
                            Text("\(lastModified, formatter: dateFormatter)")
                        }
                    }
                }
            }
            .navigationBarTitle(NSLocalizedString("categoryInfoTitle", comment: "Title for category info"))
            .navigationBarItems(trailing: Button(NSLocalizedString("doneButton", comment: "Done button label")) {
                isPresented = false
            })
        }
        .preferredColorScheme(userTheme.colorScheme)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

