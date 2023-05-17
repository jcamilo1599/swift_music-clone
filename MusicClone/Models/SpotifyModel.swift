//
//  SpotifyModel.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 2/05/23.
//

import Foundation

// MARK: - SpotifyResp
struct SpotifyResp: Codable {
    let tracks: SpotifyTracks

    enum CodingKeys: String, CodingKey {
        case tracks = "tracks"
    }
}

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
    let type: SpotifyItemType
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
    let albumType: SpotifyAlbumTypeEnum
    let artists: [SpotifyArtist]
    let availableMarkets: [String]
    let externalUrls: SpotifyExternalUrls
    let href: String
    let id: String
    let images: [SpotifyImage]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: SpotifyReleaseDatePrecision
    let totalTracks: Int
    let type: SpotifyAlbumTypeEnum
    let uri: String

    enum CodingKeys: String, CodingKey {
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

enum SpotifyAlbumTypeEnum: String, Codable {
    case album = "album"
    case compilation = "compilation"
    case single = "single"
}

// MARK: - SpotifyArtist
struct SpotifyArtist: Codable {
    let externalUrls: SpotifyExternalUrls
    let href: String
    let id: String
    let name: String
    let type: SpotifyArtistType
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

enum SpotifyArtistType: String, Codable {
    case artist = "artist"
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

enum SpotifyReleaseDatePrecision: String, Codable {
    case day = "day"
}

// MARK: - SpotifyExternalIDS
struct SpotifyExternalIDS: Codable {
    let isrc: String

    enum CodingKeys: String, CodingKey {
        case isrc = "isrc"
    }
}

enum SpotifyItemType: String, Codable {
    case track = "track"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
