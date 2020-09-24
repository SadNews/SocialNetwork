//
//  NewsFeedInteractor.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 21.09.2020.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    private var feedResponse: ModelData?
    var cursor: String?
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        
        switch request {
        case .getNewsFeed:
            fetcher.getFeed(nextBatchFrom: nil) { [weak self] (feed) in
                guard let feedResponse = feed?.data else {return}
                self?.cursor = feed?.data?.cursor
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presenNewsFeed(feed: feedResponse))
            }
            
        case .getNewBranch:
            fetcher.getFeed(nextBatchFrom: cursor) { [weak self] (feed) in
                if self?.cursor != nil{
                    guard let feedResponse = feed?.data else {return}
                    if self?.feedResponse == nil {
                        self?.feedResponse = feedResponse
                    } else {
                        self?.feedResponse?.items.append(contentsOf: (feedResponse.items))
                        self?.cursor = feed?.data?.cursor
                        guard let newFeed = self?.feedResponse else { return }
                        self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presenNewsFeed(feed: newFeed))
                    }
                }
            }
            
        case .getSortedFeed:
            self.feedResponse = nil
            fetcher.getFeed(nextBatchFrom: nil) { [weak self] (feed) in
                guard let feedResponse = feed?.data else {return}
                self?.cursor = feed?.data?.cursor
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presenNewsFeed(feed: feedResponse))
            }
        }
    }
}
