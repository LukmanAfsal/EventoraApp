//
//  CustomTabBar.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI

// MARK: - CustomTabBar View
struct CustomTabBar: View {
    // MARK: - Binding
    @Binding var selectedTab: AuraTab
    
    var body: some View {
        HStack {
            // MARK: - Tab Items
            ForEach(AuraTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    let isSelected = tab == selectedTab
                    tabItemView(for: tab, isSelected: isSelected)
                }
            }
        }
        .padding(6)
        .background(Color.black.opacity(0.5).ignoresSafeArea(edges: .bottom))
    }
    
    // MARK: - Tab Item View
    private func tabItemView(for tab: AuraTab, isSelected: Bool) -> some View {
        let item = tab.tabItem
        return VStack(spacing: 4) {
            Image(systemName: item.image)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(isSelected ? item.color : .white.opacity(0.6))
            
            Text(item.title)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(isSelected ? item.color : .white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            isSelected ? Capsule().fill(item.color.opacity(0.2)) : nil
        )
    }
}
