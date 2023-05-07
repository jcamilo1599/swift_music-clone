//
//  SpotifyAPI.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 30/04/23.
//

import Foundation
import SpotifyiOS

class SpotifyAPI {
    // Claves de acceso de la aplicación en Spotify
    private let clientId = ""
    private let clientSecret = ""
    
    // Token de acceso a la API de Spotify
    var accessToken: String?
    
    /// Solicita un token de cliente a la API de Spotify
    func requestClientCredentialsToken(completion: @escaping (Result<String, Error>) -> Void, afterSuccess: @escaping () -> Void) {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Establece el tipo de contenido de la solicitud
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Agrega la autorización a la solicitud
        let authData = "\(clientId):\(clientSecret)".data(using: .utf8)!
        let authString = "Basic " + authData.base64EncodedString()
        request.setValue(authString, forHTTPHeaderField: "Authorization")
        
        // Establece el cuerpo de la solicitud
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        
        // Realiza la solicitud
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "SpotifyAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibió ningún dato"])))
                return
            }
            
            do {
                // Analiza la respuesta
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let accessToken = json?["access_token"] as? String
                self.accessToken = accessToken
                completion(.success(accessToken ?? ""))
                afterSuccess()
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    /// Método para buscar las canciones populares en Spotify
    /// Recibe como parámetro una clausura que será llamada cuando se complete la solicitud
    func searchPopularTracks(completion: @escaping (Result<SpotifyTracks, Error>) -> Void) {
        // Comprueba que se tenga un token de acceso válido
        guard let accessToken = accessToken else {
            completion(.failure(NSError(
                domain: "SpotifyAPI",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Falta el token de acceso"]
            )))
            
            return
        }
        
        let url = URL(string: "https://api.spotify.com/v1/search?q=pop&type=track&limit=10")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Agrega la autorización a la solicitud
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Realiza la solicitud
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Si hay un error al enviar la solicitud, se llama la clausura con el error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Si la respuesta no tiene datos, se llama la clausura con un error indicando que no se recibieron datos
            guard let data = data else {
                completion(.failure(NSError(domain: "SpotifyAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos de la API de Spotify"])))
                return
            }
            
            // Se intenta interpretar la respuesta como un objeto JSON
            do {
                // Se crea un objeto JSONDecoder para decodificar la respuesta JSON a un objeto SpotifyTracks.
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // Se decodifica la respuesta JSON a un objeto SpotifyTracks.
                let spotifyTracks = try decoder.decode(SpotifyTracks.self, from: data)
                
                // Se llama al closure de finalización con el objeto SpotifyTracks decodificado.
                completion(.success(spotifyTracks))
            } catch {
                // Si hay un error al interpretar la respuesta JSON, se llama la clausura con el error
                completion(.failure(error))
            }
        }
        
        // Se inicia la tarea para enviar la solicitud HTTP
        task.resume()
    }
}
