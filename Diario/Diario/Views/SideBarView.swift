//
//  SideBarView.swift
//  Diario
//
//  Created by iredefbmac_36 on 18/08/25.
//

import SwiftUI

struct SideBarView: View {
    @Binding var sidebarOpened: Bool
    @Binding var darkMode: Bool
    @State var handlesLanguage: () -> Void
    
    var body: some View {
        ZStack {
            Color.caramel
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                TitleComponent(title: "Settings", color: .canvas, weight: .bold)
                
                HStack {
                    ButtonComponent(text: "Language", color: .espresso, shapeColor: .canvas, size: 20, width: 160, height: 40, shape: Capsule()) {
                        sidebarOpened.toggle()
                    }
                    
                    Image(systemName: "globe")
                        .font(.system(size: 32))
                        .foregroundColor(.canvas)
                }
                
                Toggle(isOn: $darkMode, label: {
                    TextComponent(text: "Change theme", color: .canvas, size: 20)
                })
                .frame(width: 212)
                
                  
                HStack {
                    ButtonComponent(text: "credits", color: .espresso, shapeColor: .canvas, size: 20, width: 160, height: 40, shape: Capsule()) {
                        sidebarOpened.toggle()
                    }
                    
                    Image(systemName: "quote.bubble.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.canvas)
                }
                
                Spacer()
            }
            .padding()
        }
        .opacity(sidebarOpened ? 1 : 0)
    }
}
