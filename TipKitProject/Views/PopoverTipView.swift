//
//  PopoverTipView.swift
//  TipKitProject
//
//  Created by Berke Turanlıoğlu on 12.08.2023.
//

import SwiftUI
import TipKit

struct PopoverTipView: View {
    
    @Environment(\.colorScheme) var mode
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("You can address more specific stuff that belongs to one component. It disappears after user taps any other space.")
                    
                    Text("It is done with ")
                    + Text(".popoverTip()")
                        .font(Font.system(.body, design: .monospaced))
                        .foregroundStyle(Color.purple)
                    Text("Example is below.")
                }
                
                Link(destination: URL(string: "https://www.apple.com")!, label: {
                    Text("Check out Apple's website!")
                })
                .popoverTip(PopoverTip())
                .task {
                    try? await Tips.configure {
                        DisplayFrequency(.immediate)
                        DatastoreLocation(.applicationDefault)
                    }
                }
                
                Spacer()
            }
            .padding(.all)
            .navigationTitle("Popover Tip")
        }
    }
}

struct PopoverTip: Tip {
    var title: Text {
        Text("Link to the website")
    }
    
    var message: Text? {
        Text("Safari will be opened after you tap the link above.")
    }
    
    var asset: Image? {
        Image(systemName: "safari")
    }
}

#Preview {
    PopoverTipView()
}
