//
//  SideBarMenu.swift
//  Diario
//
//  Created by iredefbmac_36 on 30/08/25.
//

import SwiftUI

struct SideBarMenuView: View {
    @Binding var sidebarIsOpened: Bool
    
    var body: some View {
        NavigationStack {
            if(sidebarIsOpened) {
                ZStack {
                    Rectangle()
                        .opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            sidebarIsOpened.toggle()
                        }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            SideBarView()
                        }
                        .frame(width: 300)
                        
                        Spacer()
                    }
                }
            }
        }
        .animation(.linear, value: sidebarIsOpened)
    }
}
