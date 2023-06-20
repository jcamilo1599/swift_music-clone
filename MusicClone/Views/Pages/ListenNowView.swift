//
//  ListenNowView.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 2/05/23.
//

import SwiftUI

struct ListenNowView: View {
    private let spotifyAPI = SpotifyAPI()
    
    @State private var loading: Bool = true
    @State private var tracks: SpotifyTracks?
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                }
                .padding()
                .padding(.bottom, 100)
            }
            .navigationTitle("Escuchar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                    }
                }
            }
        }
        .onAppear {
            spotifyAPI.fetchTopTracks()
        }
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ListenNowView()
    }
}
