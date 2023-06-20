//
//  IndicatorView.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 19/06/23.
//

import SwiftUI

struct IndicatorView: View {
    @Binding var progress: CGFloat
    @Binding var height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray) // Color de fondo de la cápsula
                    .frame(width: geometry.size.width, height: height)
                    .cornerRadius(10)
                
                Rectangle()
                    .foregroundColor(.white.opacity(0.5)) // Color del porcentaje
                    .frame(width: progress * geometry.size.width, height: height)
                    .cornerRadius(10)
            }
        }
        .frame(height: height)
    }
}

struct IndicatorView_Previews: PreviewProvider {
    @Namespace static private var previewNamespace
    
    static var previews: some View {
        IndicatorView(progress: .constant(0.5), height: .constant(10))
            .background(.black)
        
        SheetView(expandSheet: .constant(true), animation: previewNamespace)
    }
}
