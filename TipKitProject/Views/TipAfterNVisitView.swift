//
//  TipAfterNVisitView.swift
//  TipKitProject
//
//  Created by Berke Turanlıoğlu on 13.08.2023.
//

import SwiftUI
import TipKit

struct TipAfterNVisitView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("This tip aims to be initialized after certain amount of visits to this view.\n\nIf you enter this view three times, tip appears.\n\nHow we are able to track the number of visits is thanks to donation of tip and initializing it in onAppear.")
                    .task {
                        try? await Tips.configure {
                            DisplayFrequency(.immediate)
                            DatastoreLocation(.applicationDefault)
                        }
                    }
                
                TipView(TipAfterNVisit(), arrowEdge: .top)
                
                Text("If you enter this view five more times, the tip will disappear. This parameter is being held as ")
                + Text("TipOption")
                    .font(Font.system(.body, design: .monospaced))
                    .foregroundStyle(Color.purple)
                + Text(" in the Tip struct.")
                
                Spacer()
            }
            .onAppear {
                TipAfterNVisit.didViewAppeared.donate()
            }
            .padding(.all)
            .navigationTitle("onAppear Tip")
        }
    }
}

struct TipAfterNVisit: Tip {
    
    static let didViewAppeared: Event = Event(id: "didViewAppeared")
    
    var title: Text {
        Text("It has been three!")
            .foregroundStyle(Color.accentColor)
    }
    
    var message: Text? {
        Text("You love this view, don't you?")
    }
    
    var asset: Image? {
        Image(systemName: "heart")
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.didViewAppeared) {
                $0.donations.count >= 3
            }
        ]
    }
    
    var options: [TipOption] {
        [
            Self.MaxDisplayCount(5)
        ]
    }
}

#Preview {
    TipAfterNVisitView()
}
