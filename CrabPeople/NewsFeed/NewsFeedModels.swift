//
//  NewsFeedModels.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 21.09.2020.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case getNewBranch
                case getSortedFeed
            }
        }
        struct Response {
            enum ResponseType {
                case presenNewsFeed(feed: ModelData )
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var photoAttachement: FeedCellPhotoAttachementViewModel?
        var imageLabel: String?
        var name: String
        var date: String?
        var text: String?
        var likes: Int?
        var views: Int?
    }
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachementViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    var cells: [Cell]
}
