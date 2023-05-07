//
//  CurrentPlaybackView.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 30/04/23.
//

import SwiftUI

struct CurrentPlaybackView: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        
                        Image("queen")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: expandSheet ? 15 : 5, style: .continuous))
                    }
                    .matchedGeometryEffect(id: EffectsIds.open, in: animation)
                }
            }
            .frame(width: 50, height: 50)
            
            Text("Under Pressure (feat. David Bowie)")
                .lineLimit(1)
                .padding(.horizontal)
            
            Spacer(minLength: 0)
            
            Button {
            } label: {
                Image(systemName: "pause.fill")
                    .font(.system(size: 26))
            }
            
            Button {
            } label: {
                Image(systemName: "forward.fill")
                    .font(.system(size: 22))
            }
            .padding(.leading, 20)
        }
        .foregroundColor(.primary)
        .padding(.horizontal)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
}

struct CurrentPlayback_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
