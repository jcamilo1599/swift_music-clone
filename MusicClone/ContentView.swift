//
//  ContentView.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 30/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var expandSheet: Bool = false
    @State private var hideTabBar: Bool = false
    
    @Namespace private var animation
    
    var body: some View {
        TabView {
            ListenNowView()
                .setTabItem("Escuchar", "play.circle.fill")
                .setTabBarBackground(.init(.ultraThickMaterial))
                .hideTabBar(hideTabBar)
            
            ExploreView()
                .setTabItem("Explorar", "square.grid.2x2.fill")
                .setTabBarBackground(.init(.ultraThickMaterial))
                .hideTabBar(hideTabBar)
            
            RadioView()
                .setTabItem("Radio", "dot.radiowaves.left.and.right")
                .setTabBarBackground(.init(.ultraThickMaterial))
                .hideTabBar(hideTabBar)
            
            LibraryView()
                .setTabItem("Biblioteca", "music.note.list")
                .setTabBarBackground(.init(.ultraThickMaterial))
                .hideTabBar(hideTabBar)
            
            SearchView()
                .setTabItem("Buscar", "magnifyingglass")
                .setTabBarBackground(.init(.ultraThickMaterial))
                .hideTabBar(hideTabBar)
        }
        .tint(.red)
        .safeAreaInset(edge: .bottom) {
            buildBottomSheet()
        }
        .overlay {
            if expandSheet {
                SheetView(expandSheet: $expandSheet, animation: animation)
                    .transition(.asymmetric(
                        insertion: .identity,
                        removal: .offset(y: -5)
                    ))
            }
        }
        .onChange(of: expandSheet) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + (newValue ? 0.04 : 0.03)) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    hideTabBar = newValue
                }
            }
        }
    }
    
    /// Renderiza el contenedor de la canción que se este reproduciendo en el momento
    private func buildBottomSheet() -> some View {
        ZStack {
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            } else {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay {
                        CurrentPlaybackView(expandSheet: $expandSheet, animation: animation)
                    }
                    .matchedGeometryEffect(id: EffectsIds.close, in: animation)
            }
        }
        .frame(height: 70)
        .overlay(alignment: .bottom, content: {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
        })
        /// 49: tab bar height iPhone
        /// 45: tab bar height iPad
        .offset(y: UIDevice.current.userInterfaceIdiom == .pad ? -45 : -49)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
