//
//  API.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 19.09.2020.
//

import Foundation

struct API {
    static let scheme = "http"
    static let host = "stage.apianon.ru"
    static let port = 3000
    static let newsFeed = "/fs-posts/v1/posts"
    static var orderBy = "createdAt"

}
