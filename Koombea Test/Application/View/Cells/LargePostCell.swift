//
//  LargePostCell.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 17/01/21.
//

import UIKit

class LargePostCell: BasePostCell {
    
    @IBOutlet private weak var picsStackView: UIStackView!
    private let bottomStackView = UIStackView()
    
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
        
        bottomStackView.arrangedSubviews.forEach {
            bottomStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    override func setupView(with post: Post) {
        super.setupView(with: post)
        
        post.detail.pics.enumerated().forEach { index, pic in
            let imageView = RemoteImageView(url: pic)
            imageView.onAction = { [weak self] in
                guard let image = $0 else { return }
                self?.delegate?.postCellDidSelectImage(image)
            }
            
            let constraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
            constraint.isActive = true
            
            if index == 0 {
                picsStackView.addArrangedSubview(imageView)
            } else {
                if bottomStackView.superview == nil {
                    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
                    bottomStackView.axis = .horizontal
                    bottomStackView.distribution = .fillEqually
                    bottomStackView.spacing = 8
                    picsStackView.addArrangedSubview(bottomStackView)
                }
                bottomStackView.addArrangedSubview(imageView)
            }
        }
    }
}
