//
//  BasePostCell.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 17/01/21.
//

import UIKit

class BasePostCell: UITableViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func setupView(with post: Post) {
        pictureImageView.af.setImage(withURL: post.authorPicture)
        nameLabel.text = post.author
        emailLabel.text = post.authorEmail
        dateLabel.text = post.detail.dateFormatted
    }
}
