//
//  NewsFeedViewController.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 21.09.2020.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

final class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    let tableView = UITableView()
    // MARK: Object lifecycle
    private var feedViewModel = FeedViewModel.init(cells: [])
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Order by \(API.orderBy)", style: .plain, target: self, action: #selector(tapButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
        setupTableView()
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed( let feedViewModel):
            self.feedViewModel = feedViewModel
            tableView.reloadData()
        }
    }
    
    @objc func tapButton() {
        switch API.orderBy {
        case "createdAt":
            API.orderBy = "mostCommented"
        case "mostCommented":
            navigationItem.rightBarButtonItem?.tag = 0
            API.orderBy = "mostPopular"
        case "mostPopular":
            API.orderBy = "createdAt"
        default:
            print("Error case")
        }
        navigationItem.rightBarButtonItem?.title = "Order by \(API.orderBy)"
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getSortedFeed)

    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height * 0.8 {
            interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewBranch)
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        cell.selectionStyle = .none
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        router?.routeToCourseDetails(data: cellViewModel)
    }
    
}
