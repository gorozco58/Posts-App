//
//  RemoteImageView.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import UIKit
import AlamofireImage

class RemoteImageView: UIView {
    let imageView = UIImageView(frame: .zero)
    let indicator = UIActivityIndicatorView(style: .medium)
    private let actionButton = UIButton(type: .custom)
    
    var onAction: ((UIImage?) -> Void)?
    
    init(url: URL) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        loadImage(from: url)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        clipsToBounds = true
        backgroundColor = .systemGray6
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addFillConstraints(to: imageView)
                
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        addSubview(actionButton)
        addFillConstraints(to: actionButton)
    }
    
    func loadImage(from url: URL) {
        indicator.startAnimating()
        imageView.image = nil
        
        imageView.af.setImage(withURL: url,
                              cacheKey: url.absoluteString,
                              completion:  { [indicator, imageView] response in
            indicator.stopAnimating()
            if case .success(let image) = response.result {
                imageView.image = image
            }
        })
    }
}

//MARK: - Private methods
private extension RemoteImageView {
    
    func addFillConstraints(to view: UIView) {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["view" : view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["view" : view]))
    }
    
    @objc func buttonPressed() {
        onAction?(imageView.image)
    }
}
