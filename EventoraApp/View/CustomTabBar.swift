//
//  CustomTabBar.swift
//  EventoraApp
//
//  Created by jeboy on 19/02/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: AuraTab
    
    var body: some View {
        HStack {
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




