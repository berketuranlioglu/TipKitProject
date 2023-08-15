//
//  NavBarTipView.swift
//  TipKitProject
//
//  Created by Berke Turanlıoğlu on 13.08.2023.
//

import SwiftUI
import TipKit

struct NavBarTipView: View {
    
    @State private var groceryList = [
        "Bread",
        "Meat",
        "Rice",
        "Butter",
        "Milk"
    ]
    
    @State var newItem: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 60)
                
                Text("Navigation Bar items have special type of tips.\n\nThese tips have built-in shadowed primary color background and its arrows are coming from the corners.")
                    .padding(.all)
                
                List {
                    Section {
                        ForEach(groceryList, id: \.self) { item in
                            Text(item)
                        }
                        .onDelete { groceryList.remove(atOffsets: $0) }
                        .onMove { groceryList.move(fromOffsets: $0, toOffset: $1) }
                    } header: {
                        Text("Grocery List")
                    }
                }
                .toolbar {
                    EditButton()
                        .popoverTip(NavBarTip())
                        .task {
                            try? await Tips.configure {
                                DisplayFrequency(.immediate)
                                DatastoreLocation(.applicationDefault)
                            }
                        }
                }
                .listStyle(.plain)
                
                HStack {
                    Text("Add new item:")
                    TextField("e.g., Apple", text: $newItem)
                    Button {
                        groceryList.append(newItem)
                        newItem = ""
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .padding(.all)
            }
            .navigationTitle("Nav Bar Tip")
        }
    }
}

struct NavBarTip: Tip {
    var title: Text {
        Text("Lists are customizable.")
    }
    
    var message: Text? {
        Text("You can edit the list by rearranging or removing some items!")
    }
}

#Preview {
    NavBarTipView()
}
