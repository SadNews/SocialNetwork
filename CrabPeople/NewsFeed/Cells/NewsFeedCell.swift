//
//  NewsFeedCell.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 20.09.2020.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var imageLabel: String? { get }
    var date: String? { get }
    var name: String { get }
    var text: String? { get }
    var likes: Int? { get }
    var views: Int? { get }
    var photoAttachement: FeedCellPhotoAttachementViewModel? { get }
    
}

protocol FeedCellPhotoAttachementViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
        
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 7
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Book", size: 10)
        label.textColor = UIColor.gray
        return label
    }()
    
    let hasImage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Book", size: 15)
        label.text = "Есть фото - "
        label.textColor = UIColor.gray
        return label
    }()
    
    var imageLabel: WebImageView = {
        var imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    let imagePost: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(imageLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(imagePost)
        contentView.addSubview(hasImage)
        imageLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        nameLabel.anchor(top: contentView.topAnchor, leading: imageLabel.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        dateLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0))
        hasImage.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 8, bottom: 16, right: 0))
        imagePost.anchor(top: nil, leading: hasImage.trailingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 0), size: CGSize(width: 40, height: 40))
        detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: imagePost.topAnchor, constant: -16).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 8).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: FeedCellViewModel) {
        imageLabel.set(imageURL: viewModel.imageLabel ?? "")
        dateLabel.text = viewModel.date
        nameLabel.text = viewModel.name.trimmingCharacters(in: .newlines)
        detailLabel.text = viewModel.text
        if let photoAttachment = viewModel.photoAttachement {
            imagePost.set(imageURL: photoAttachment.photoUrlString ?? "")
            imagePost.isHidden = false
            hasImage.isHidden = false
        } else {
            imagePost.isHidden = true
            hasImage.isHidden = true
        }
        
    }
}
