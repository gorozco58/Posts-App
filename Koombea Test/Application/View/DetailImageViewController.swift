//
//  DetailImageViewController.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 17/01/21.
//

import UIKit

class DetailImageViewController: UIViewController {
    
    @IBOutlet private weak var pictureImageView: UIImageView!
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: String(describing: DetailImageViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureImageView.image = image
    }
}
