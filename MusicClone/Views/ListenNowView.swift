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
            getTracks()
        }
    }
    
    /// Obtiene las canciones populares
    private func getTracks() {
        spotifyAPI.requestClientCredentialsToken(completion: { result in
            switch result {
            case .success(_): break
            case .failure(let error):
                loading.toggle()
                print("Error obteniendo el token de acceso: \(error.localizedDescription)")
            }
        }, afterSuccess: {
            spotifyAPI.searchPopularTracks { result in
                loading.toggle()
                
                switch result {
                case .success(let response):
                    tracks = response
                case .failure(let error):
                    print("Error buscando las canciones populares: \(error.localizedDescription)")
                }
            }
        })
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ListenNowView()
    }
}
