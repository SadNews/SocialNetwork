//
//  Model.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 19.09.2020.
//

import Foundation

struct Model: Decodable {
    var data: ModelData?
    let errors: String?
}

// MARK: - ModelData
struct ModelData: Decodable {
    var items: [Item]
    let cursor: String?
}

// MARK: - Item
struct Item: Decodable {
    let id: String?
    let type, status: String?
    let coordinates: Coordinates?
    let isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile: Bool?
    let contents: [Content]?
    let language: String?
    let createdAt, updatedAt: Double?
    let author: Author?
    let stats: Stats?
    let isMyFavorite: Bool?
}

// MARK: - Author
struct Author: Decodable {
    let id: String?
    let url: String?
    let name: String?
    let banner: Banner?
    let photo: Photo?
    let gender: String?
    let isHidden, isBlocked, isMessagingAllowed: Bool?
    let auth: Auth?
    let statistics: Statistics?
    let tagline: String?
    let data: AuthorData?
}

// MARK: - Auth
struct Auth: Decodable {
    let rocketId: String?
    let isDisabled: Bool?
    let level: Int?
}

// MARK: - Banner
struct Banner: Decodable {
    let type, id: String?
    let data: BannerData?
}

// MARK: - BannerData
struct BannerData: Decodable {
    let extraSmall, small, original: ExtraSmall?
}

// MARK: - ExtraSmall
struct ExtraSmall: Decodable {
    let url: String?
    let size: Size?
}

// MARK: - Size
struct Size: Decodable {
    let width, height: Int?
}

// MARK: - AuthorData
struct AuthorData: Decodable {
}

// MARK: - Photo
struct Photo: Decodable {
    let type, id: String?
    let data: PhotoData?
}

// MARK: - PhotoData
struct PhotoData: Decodable {
    let extraSmall, small, original: ExtraSmall?
}

// MARK: - Statistics
struct Statistics: Decodable {
    let likes, thanks: Int?
    let uniqueName: Bool?
    let thanksNextLevel: Int?
}

// MARK: - Content
struct Content: Decodable {
    let type: String?
    let id: String?
    let data: ContentData?
}

// MARK: - ContentData
struct ContentData: Decodable {
    let extraSmall, small: ExtraSmall?
    let value: String?
    let values: [String]?
}

// MARK: - Coordinates
struct Coordinates: Decodable {
    let latitude, longitude: Double?
}

// MARK: - Stats
struct Stats: Decodable {
    let likes, views, comments, shares: Comments?
    let replies, timeLeftToSpace: Comments?
}

// MARK: - Comments
struct Comments: Decodable {
    let count: Int?
    let my: Bool?
}
