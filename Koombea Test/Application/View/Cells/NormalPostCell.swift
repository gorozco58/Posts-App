//
//  NormalPostCell.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import UIKit

class NormalPostCell: BasePostCell {
    @IBOutlet private weak var picsStackView: UIStackView!
    
    weak var delegate: PostCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pictureImageView.layer.cornerRadius = pictureImageView.frame.height / 2
        pictureImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
        
        picsStackView.arrangedSubviews.forEach {
            picsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }

    override func setupView(with post: Post) {
        super.setupView(with: post)
        
        let pics = post.detail.pics.count <= 2 ? post.detail.pics : Array(post.detail.pics.prefix(upTo: 2))
        
        pics.forEach { pic in
            let imageView = RemoteImageView(url: pic)
            imageView.onAction = { [weak self] in
                guard let image = $0 else { return }
                self?.delegate?.postCellDidSelectImage(image)
            }
            
            let constraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
            constraint.isActive = true
            constraint.priority = UILayoutPriority(750)
            picsStackView.addArrangedSubview(imageView)
        }
    }
}
