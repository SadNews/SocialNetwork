//
//  ShowDetailsViewController.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 23.09.2020.
//

import UIKit

class ShowDetailsViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var model: FeedViewModel.Cell? = nil
    private var viewModel: ShowDetailsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupViews()
        set()
    }
    
    func configure(viewModel: ShowDetailsViewController, data: FeedViewModel.Cell) {
        self.viewModel = viewModel
        model = data
    }
    
    func setupScrollView(){
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(imagePost)
        contentView.addSubview(dateLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        nameLabel.anchor(top: contentView.topAnchor, leading: imageLabel.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: -16))
        imageLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0), size: CGSize(width: 100, height: 100))
        dateLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0))
        imagePost.anchor(top: nil, leading: contentView.leadingAnchor, bottom: likesLabel.topAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8), size: CGSize(width: 0, height: 320))
        likesLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 0))
        viewsLabel.anchor(top: nil, leading: nil, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 16))
        
        detailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 25).isActive = true
        detailLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: imagePost.topAnchor, constant: -16).isActive = true
        
        
    }
    
    let imageLabel: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    let imagePost: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Book", size: 15)
        label.textColor = UIColor.gray
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Просмотров - "
        label.font = UIFont(name: "Avenir-Book", size: 15)
        label.textColor = UIColor.gray
        return label
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Лайков - "
        label.font = UIFont(name: "Avenir-Book", size: 15)
        label.textColor = UIColor.gray
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21)
        label.numberOfLines = 0
        return label
    }()
    
    func set() {
        imageLabel.set(imageURL: model?.imageLabel ?? "")
        dateLabel.text = model?.date
        nameLabel.text = model?.name.trimmingCharacters(in: .newlines)
        detailLabel.text = model?.text
        likesLabel.text = String("Лайков - \(model?.likes ?? 0)")
        viewsLabel.text = String("Просмотров - \(model?.views ?? 0)")
        if let photoAttachment = model?.photoAttachement {
            imagePost.set(imageURL: photoAttachment.photoUrlString ?? "")
            imagePost.isHidden = false
        } else {
            imagePost.isHidden = true
        }
    }
}
