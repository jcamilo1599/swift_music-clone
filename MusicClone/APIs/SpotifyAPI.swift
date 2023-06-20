//
//  SpotifyAPI.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 30/04/23.
//

import Foundation
import Alamofire

class SpotifyAPI {
    let clientId = "e3566ac81b8141c8af1c7e6572dbcce7"
    let clientSecret = "b580e33181f641a8ae4e73c5c10be087"
    
    private func getToken(completion: @escaping (String?) -> Void) {
        let url = "https://accounts.spotify.com/api/token"
        let parameters = ["grant_type": "client_credentials"]
        let headers = HTTPHeaders([
            .authorization(username: clientId, password: clientSecret),
            .contentType("application/x-www-form-urlencoded")
        ])
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.value as? [String: Any], let accessToken = json["access_token"] as? String {
                print("Token: \(accessToken)")
                completion(accessToken)
            } else {
                print("No se obtuvo token")
                completion(nil)
            }
        }
    }
    
    func fetchTopTracks() {
        getToken() { token in
            if let accessToken = token {
                let url = "https://api.spotify.com/v1/search?q=pop&type=track&limit=10"
                let headers = HTTPHeaders([
                    .authorization(bearerToken: accessToken)
                ])
                
                AF.request(url, headers: headers).responseDecodable(of: SpotifyResp.self) { response in
                    if let tracks = response.value?.tracks {
                        print(tracks)
                    } else {
                        print("Error mapeando las canciones")
                    }
                }
            }
        }
    }
}
