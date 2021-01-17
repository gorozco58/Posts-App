//
//  PictureCell.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 17/01/21.
//

import UIKit

class PictureCell: UICollectionViewCell {

    @IBOutlet private weak var mainPicImageView: RemoteImageView!
    
    weak var delegate: PostCellDelegate?
    
    func setupView(with url: URL) {
        mainPicImageView.loadImage(from: url)
        mainPicImageView.onAction = { [weak self] in
            guard let image = $0 else { return }
            self?.delegate?.postCellDidSelectImage(image)
        }
    }
}
