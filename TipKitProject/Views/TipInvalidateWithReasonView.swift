//
//  TipInvalidateWithReasonView.swift
//  TipKitProject
//
//  Created by Berke Turanlıoğlu on 13.08.2023.
//

import SwiftUI
import TipKit

struct TipInvalidateWithReasonView: View {
    
    let iosVersions: [Double] = [13.0, 14.0, 15.0, 16.0, 17.0]
    let xcodeVersions: [Double] = [11.0, 12.0, 13.0, 14.0, 15.0]
    
    @State var selectedIos: Double = 13.0
    @State var selectedXcode: Double = 11.0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Tips can be invalidated under certain reasons in order not to poke user every time the view has been appeared.")
                
                Text("The invalidation is done with\n")
                + Text(".invalidate(\n\treason: .userPerformedAction\n)")
                    .font(Font.system(.body, design: .monospaced))
                    .foregroundStyle(Color.purple)
                
                Text("In this example, the tip will be ignored after the latest iOS and Xcode versions are selected.")
                    .multilineTextAlignment(.leading)
                
                Spacer()
                    .frame(height: 40)
                
                HStack {
                    Text("iOS Version for TipKit:")
                    Spacer()
                    Picker("iOS Version Selection", selection: $selectedIos) {
                        ForEach(iosVersions, id: \.self) { ver in
                            Text("\(ver, specifier: "%.1f")")
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Xcode Version for TipKit:")
                    Spacer()
                    Picker("Xcode Version Selection", selection: $selectedXcode) {
                        ForEach(xcodeVersions, id: \.self) { ver in
                            Text("\(ver, specifier: "%.1f")")
                        }
                    }
                }
                .padding(.horizontal)
                .task {
                    try? await Tips.configure {
                        DisplayFrequency(.immediate)
                        DatastoreLocation(.applicationDefault)
                    }
                }
                
                TipView(TipInvalidateWithReason(), arrowEdge: .top)
                
                Button("Done") {
                    if selectedIos == 17.0 && selectedXcode == 15.0 {
                        TipInvalidateWithReason().invalidate(reason: .userPerformedAction)
                    }
                }
                .padding(.all)
                
                Spacer()
            }
            .padding(.all)
            .navigationTitle("Invalidatable Tip")
        }
    }
}

struct TipInvalidateWithReason: Tip {
    var title: Text {
        Text("Here's a tip!")
    }
    
    var message: Text? {
        Text("Latest iOS and Xcode versions support TipKit.")
    }
    
    var asset: Image? {
        Image(systemName: "lightbulb")
    }
}

#Preview {
    TipInvalidateWithReasonView()
}
