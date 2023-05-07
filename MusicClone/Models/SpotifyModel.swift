//
//  SpotifyModel.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 2/05/23.
//

import Foundation

// MARK: - SpotifyTracks
struct SpotifyTracks: Codable {
    let href: String
    let items: [SpotifyItem]
    let limit: Int
    let next: String
    let offset: Int
    let previous: JSONNull?
    let total: Int

    enum CodingKeys: String, CodingKey {
        case href = "href"
        case items = "items"
        case limit = "limit"
        case next = "next"
        case offset = "offset"
        case previous = "previous"
        case total = "total"
    }
}

// MARK: - SpotifyItem
struct SpotifyItem: Codable {
    let album: SpotifyAlbum
    let artists: [SpotifyArtist]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMS: Int
    let explicit: Bool
    let externalIDS: SpotifyExternalIDS
    let externalUrls: SpotifyExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let popularity: Int
    let previewURL: String
    let trackNumber: Int
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case album = "album"
        case artists = "artists"
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit = "explicit"
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case isLocal = "is_local"
        case name = "name"
        case popularity = "popularity"
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type = "type"
        case uri = "uri"
    }
}

// MARK: - SpotifyAlbum
struct SpotifyAlbum: Codable {
    let albumGroup: String
    let albumType: String
    let artists: [SpotifyArtist]
    let availableMarkets: [String]
    let externalUrls: SpotifyExternalUrls
    let href: String
    let id: String
    let images: [SpotifyImage]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let totalTracks: Int
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case albumGroup = "album_group"
        case albumType = "album_type"
        case artists = "artists"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type = "type"
        case uri = "uri"
    }
}

// MARK: - SpotifyArtist
struct SpotifyArtist: Codable {
    let externalUrls: SpotifyExternalUrls
    let href: String
    let id: String
    let name: String
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case name = "name"
        case type = "type"
        case uri = "uri"
    }
}

// MARK: - SpotifyExternalUrls
struct SpotifyExternalUrls: Codable {
    let spotify: String

    enum CodingKeys: String, CodingKey {
        case spotify = "spotify"
    }
}

// MARK: - SpotifyImage
struct SpotifyImage: Codable {
    let height: Int
    let url: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
    }
}

// MARK: - SpotifyExternalIDS
struct SpotifyExternalIDS: Codable {
    let isrc: String

    enum CodingKeys: String, CodingKey {
        case isrc = "isrc"
    }
}

// Esta clase representa el valor nulo en JSON.
class JSONNull: Codable, Hashable {
    // Implementación del operador de igualdad
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        // Siempre se considera que dos instancias de JSONNull son iguales.
        return true
    }

    // Implementación del método hash(into:).
    public func hash(into hasher: inout Hasher) {
        // Siempre se le asigna el valor 0 al hash de una instancia de JSONNull.
        hasher.combine(0)
    }

    // Constructor por defecto.
    public init() {}

    // Implementación del constructor desde un decoder.
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            // Si el valor no es nulo, se lanza un error de tipo.
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Valor incorrecto para JSONNull"))
        }
    }

    // Implementación del método encode(to:).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        // Se codifica el valor nulo.
        try container.encodeNil()
    }
}
