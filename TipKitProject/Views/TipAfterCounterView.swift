//
//  TipAfterCounterView.swift
//  TipKitProject
//
//  Created by Berke Turanlıoğlu on 13.08.2023.
//

import SwiftUI
import TipKit

struct TipAfterCounterView: View {
    
    @State var counter: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Not all rules should or must appear when the view comes immediately. We are also able to trigger it after some set of events.\n\nFor instance, below you will see a tip after you max the counter, which is 10.")
                
                Text("At each increase, current situation is donated with ")
                + Text(".donate()")
                    .font(Font.system(.body, design: .monospaced))
                    .foregroundStyle(Color.purple)
                + Text(" to event in Tip struct. When it gets 10, the tip is initialized.")
                
                Text("This example is for ")
                + Text(".popoverTip()")
                    .font(Font.system(.body, design: .monospaced))
                    .foregroundStyle(Color.purple)
                + Text(". In addition, ")
                + Text("TipView()")
                    .font(Font.system(.body, design: .monospaced))
                    .foregroundStyle(Color.purple)
                + Text(" tips can be triggered as well.")
                
                Spacer()
                    .frame(height: 4)
                
                Text("Counter: \(counter)")
                
                Button {
                    if counter < 10 {
                        counter += 1
                        TipAfterCounter.didIncrementCounter.donate()
                    } else {
                        counter = 0
                    }
                } label: {
                    Text(counter == 10 ? "Reset": "Increment")
                        .foregroundStyle(counter == 10 ? Color.red : Color.accentColor)
                }
                .popoverTip(TipAfterCounter(), arrowEdge: .top)
                .task {
                    try? await Tips.configure {
                        DisplayFrequency(.immediate)
                        DatastoreLocation(.applicationDefault)
                    }
                }
                
                Spacer()
            }
            .padding(.all)
            .navigationTitle("Triggered Tip")
        }
    }
}

struct TipAfterCounter: Tip {
    
    static let didIncrementCounter: Event = Event(id: "didIncrementCounter")
    
    var title: Text {
        Text("Maxed out!")
            .foregroundStyle(Color.accentColor)
    }
    
    var message: Text? {
        Text("You can no longer increment but reset the counter.")
    }
    
    var asset: Image? {
        Image(systemName: "exclamationmark")
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.didIncrementCounter) {
                $0.donations.count == 10
            }
        ]
    }
}

#Preview {
    TipAfterCounterView()
}
