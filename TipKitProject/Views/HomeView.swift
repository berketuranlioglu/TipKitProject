//
//  HomeView.swift
//  TipKitProject
//
//  Created by Berke Turanlıoğlu on 12.08.2023.
//

import SwiftUI
import TipKit

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Check the Tip examples from the views below.")
                    .padding(.horizontal, 20)
                
                List {
                    Section {
                        NavigationLink(destination: PopoverTipView(), label: {
                            Text("Popover Tip")
                                .foregroundStyle(Color.accentColor)
                        })
                        NavigationLink(destination: InlineTipView(), label: {
                            Text("Inline Tip")
                                .foregroundStyle(Color.accentColor)
                        })
                        NavigationLink(destination: NavBarTipView(), label: {
                            Text("Navigation Bar Tip")
                                .foregroundStyle(Color.accentColor)
                        })
                    } header: {
                        Text("Simple Tips")
                    }
                    
                    Section {
                        NavigationLink(destination: TipAfterCounterView(), label: {
                            Text("Tip after triggering with counter")
                                .foregroundStyle(Color.accentColor)
                        })
                        NavigationLink(destination: TipAfterNVisitView(), label: {
                            Text("Tip after number of visits")
                                .foregroundStyle(Color.accentColor)
                        })
                        NavigationLink(destination: TipInvalidateWithReasonView(), label: {
                            Text("Tip gets invalidated after a reason")
                                .foregroundStyle(Color.accentColor)
                        })
                    } header: {
                        Text("Rule-based Tips")
                    }
                }
                .listStyle(.plain)
                
                Spacer()
            }
            .padding(.vertical, 12)
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
