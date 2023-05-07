//
//  ViewExtension.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 2/05/23.
//

import SwiftUI

extension View {
    /// Crea un elemento de pestaña para la vista y establece su título y su icono.
    func setTabItem(_ title: String, _ icon: String) -> some View {
        self
            .tabItem {
                Image(systemName: icon)
                Text(title)
            }
    }
    
    /// Establece el fondo de la barra de pestañas con el estilo proporcionado.
    @ViewBuilder
    func setTabBarBackground(_ style: AnyShapeStyle) -> some View {
        self
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(style, for: .tabBar)
    }
    
    /// Oculta o muestra la barra de pestañas.
    @ViewBuilder
    func hideTabBar(_ status: Bool) -> some View {
        self
            .toolbar(status ? .hidden : .visible, for: .tabBar)
    }
    
    @ViewBuilder
    func withBaseTabs() -> some View {
        self
    }
}
