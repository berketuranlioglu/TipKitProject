//
//  InlineTipView.swift
//  TipKitProject
//
//  Created by Berke Turanlıoğlu on 12.08.2023.
//

import SwiftUI
import TipKit

struct InlineTipView: View {
    
    @Environment(\.colorScheme) var mode
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("This Tip View provides a more fluent UI since it blends itself with the main flow.")
                    
                    Text("Its biggest advantage is that the tip is permanent unless the user closes it.")
                    
                    Text("It is done with ")
                    + Text("TipView()")
                        .font(Font.system(.body, design: .monospaced))
                        .foregroundStyle(Color.purple)
                    + Text(" as a separate View component like others.")
                    
                    Text("Example is below.")
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    TipView(InlineTip())
                    ScrollView {
                        ForEach(1..<21, id:\.self) { i in
                            HStack {
                                Text("Item \(i)")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.secondary)
                                    .opacity(mode == .dark ? 0.2 : 0.1)
                            )
                        }
                        .task {
                            try? await Tips.configure {
                                DisplayFrequency(.immediate)
                                DatastoreLocation(.applicationDefault)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.all, 20)
            .navigationTitle("Inline Tip")
        }
    }
}

struct InlineTip: Tip {
    var title: Text {
        Text("This view has a list.")
    }
    
    var message: Text? {
        Text("You can scroll the list to see further down.")
    }
}

#Preview {
    InlineTipView()
}
