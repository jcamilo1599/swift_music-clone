//
//  LosslessView.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 19/06/23.
//

import SwiftUI

struct LosslessView: View {
    var body: some View {
        HStack {
            Image(systemName: "waveform")
                .font(.system(size: 12))
                .foregroundColor(.white)
            
            Text("Lossless")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.2))
            
        )
    }
}

struct LosslessView_Previews: PreviewProvider {
    @Namespace static private var previewNamespace
    
    static var previews: some View {
        LosslessView()
            .background(.black)
        
        SheetView(expandSheet: .constant(true), animation: previewNamespace)
    }
}
