// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let twitchVideosAPI = try? newJSONDecoder().decode(TwitchVideosAPI.self, from: jsonData)

import Foundation

// MARK: - TwitchVideosAPI
class TwitchVideosAPI: Codable {
    let status: Int
    let data: TwitchVideosAPIData
    let errors: Errors?
    init(status: Int, data: TwitchVideosAPIData, errors: Errors?) {
        self.status = status
        self.data = data
        self.errors = errors

    }
}

// MARK: - TwitchVideosAPIData
class TwitchVideosAPIData: Codable {
    let message: String
    let data: TwitchDataData

    init(message: String, data: TwitchDataData) {
        self.message = message
        self.data = data
    }
}

// MARK: - DataData
class TwitchDataData: Codable {
    let twitchVideos: [TwitchVideo]

    enum CodingKeys: String, CodingKey {
        case twitchVideos = "twitch-videos"
    }

    init(twitchVideos: [TwitchVideo]) {
        self.twitchVideos = twitchVideos
    }
}

// MARK: - TwitchVideo
class TwitchVideo: Codable {
    let id: Int
    let twitchID, streamID, userID: String
    let userLogin, userName: String?
    let title, twitchVideoDescription: String
    let url: String
    let thumbnailURL: String
    let viewable: String?
    let viewCount: String?
    let language: String?
    let type: String?
    let duration, mutedSegments, videoCreatedAt, videoPublishedAt: String
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case twitchID = "twitch_id"
        case streamID = "stream_id"
        case userID = "user_id"
        case userLogin = "user_login"
        case userName = "user_name"
        case title
        case twitchVideoDescription = "description"
        case url
        case thumbnailURL = "thumbnail_url"
        case viewable
        case viewCount = "view_count"
        case language, type, duration
        case mutedSegments = "muted_segments"
        case videoCreatedAt = "video_created_at"
        case videoPublishedAt = "video_published_at"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int, twitchID: String, streamID: String, userID: String, userLogin: String?, userName: String?, title: String, twitchVideoDescription: String, url: String, thumbnailURL: String, viewable: String?, viewCount: String, language: String?, type: String?, duration: String, mutedSegments: String, videoCreatedAt: String, videoPublishedAt: String, status: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.twitchID = twitchID
        self.streamID = streamID
        self.userID = userID
        self.userLogin = userLogin
        self.userName = userName
        self.title = title
        self.twitchVideoDescription = twitchVideoDescription
        self.url = url
        self.thumbnailURL = thumbnailURL
        self.viewable = viewable
        self.viewCount = viewCount
        self.language = language
        self.type = type
        self.duration = duration
        self.mutedSegments = mutedSegments
        self.videoCreatedAt = videoCreatedAt
        self.videoPublishedAt = videoPublishedAt
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

//enum CreatedAt: String, Codable {
//    case the20221019123618 = "2022-10-19 12:36:18"
//}
//
//enum Language: String, Codable {
//    case en = "en"
//}
//
//enum TwitchStatus: String, Codable {
//    case active = "active"
//}
//
//enum TypeEnum: String, Codable {
//    case archive = "archive"
//    case highlight = "highlight"
//}
//
//enum UpdatedAt: String, Codable {
//    case the20221019135658 = "2022-10-19 13:56:58"
//}
//
//enum TwitchUser: String, Codable {
//    case cxmmunity = "cxmmunity"
//}
//
//enum Viewable: String, Codable {
//    case viewablePublic = "public"
//}
