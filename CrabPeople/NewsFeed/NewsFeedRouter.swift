//
//  NewsFeedRouter.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 21.09.2020.
//

import UIKit

protocol NewsFeedRoutingLogic {
    func routeToCourseDetails(data: FeedViewModel.Cell)
}

class NewsFeedRouter: NSObject, NewsFeedRoutingLogic {
    
    weak var viewController: NewsFeedViewController?
    var dataStore: Model?
    
    // MARK: Routing
    func routeToCourseDetails(data: FeedViewModel.Cell) {
        let loadVC = ShowDetailsViewController()
        loadVC.configure(viewModel: ShowDetailsViewController(), data: data)
        viewController?.navigationController?.pushViewController(loadVC, animated: true)
    }
}
