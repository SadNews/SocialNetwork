//
//  NewsFeedPresenter.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 21.09.2020.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    var cursor: String?
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
        
        case .presenNewsFeed(let feed):
            self.cursor = feed.cursor
            let cells = feed.items.map { (item) in
                cellViewModel(from: item)
                
            }
            
            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    private func cellViewModel(from item: Item ) -> FeedViewModel.Cell {
        let photoAttachment = self.photoAttachment(feedItem: item)
        
        let hasText = findText(feedItem: item)
        let date = Date(timeIntervalSince1970: item.updatedAt ?? 0)
        let dateTitle = dateFormatter.string(from: date)
        return FeedViewModel.Cell.init(photoAttachement: photoAttachment,
                                       imageLabel: item.author?.photo?.data?.extraSmall?.url,
                                       name: item.author?.name ?? "NoName",
                                       date: dateTitle,
                                       text: hasText,
                                       likes: item.stats?.likes?.count,
                                       views: item.stats?.views?.count)
        
    }
    
    private func photoAttachment(feedItem: Item) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let item = feedItem.contents else {return nil}
        for item in item {
            if item.type == "IMAGE" {
                guard let photos = item.data?.small else { return nil }
                return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photos.url, width: photos.size?.width ?? 0, height: photos.size?.height ?? 0)
            }
        }
        return nil
    }
    
    func findText(feedItem: Item) -> String {
        guard let item = feedItem.contents else {return ""}
        for item in item {
            if item.type == "TEXT" {
                guard let text = item.data?.value else {return ""}
                return text
            }
        }
        return ""
    }
}
