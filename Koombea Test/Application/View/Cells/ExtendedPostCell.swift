//
//  ExtendedPostCell.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 17/01/21.
//

import UIKit

class ExtendedPostCell: BasePostCell {
    @IBOutlet private weak var mainPicImageView: RemoteImageView!
    @IBOutlet private weak var picsCollectionView: UICollectionView!
    
    weak var delegate: PostCellDelegate?
    private var pics: [URL] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picsCollectionView.dataSource = self
        picsCollectionView.delegate = self
        picsCollectionView.registerCell(PictureCell.self)
    }
    
    override func setupView(with post: Post) {
        super.setupView(with: post)
        
        pics = post.detail.pics
        mainPicImageView.loadImage(from: pics.removeFirst())
        mainPicImageView.onAction = { [weak self] in
            guard let image = $0 else { return }
            self?.delegate?.postCellDidSelectImage(image)
        }
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ExtendedPostCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pic = pics[indexPath.row]
        let cell: PictureCell = collectionView.dequeueCell(at: indexPath)
        cell.setupView(with: pic)
        cell.delegate = delegate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
}
