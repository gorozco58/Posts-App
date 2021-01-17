//
//  HomeViewControllerDataSource.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import UIKit

protocol HomeViewControllerDataSourceProvider: class {
    var posts: [Post] { get }
    
    func homeViewControllerDidSelectImage(_ image: UIImage)
}

protocol PostCellDelegate: class {
    func postCellDidSelectImage(_ image: UIImage)
}

class HomeViewControllerDataSource: NSObject, UITableViewDataSource {
    weak var provider: HomeViewControllerDataSourceProvider?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = provider?.posts[indexPath.row] else { return UITableViewCell() }
        
        switch post.style {
        case .normal:
            let cell: NormalPostCell = tableView.dequeueCell(at: indexPath)
            cell.setupView(with: post)
            cell.delegate = self
            return cell
        case .large:
            let cell: LargePostCell = tableView.dequeueCell(at: indexPath)
            cell.setupView(with: post)
            cell.delegate = self
            return cell
        case .extended:
            let cell: ExtendedPostCell = tableView.dequeueCell(at: indexPath)
            cell.setupView(with: post)
            cell.delegate = self
            return cell
        }
    }
}

//MARK: - PostCellDelegate
extension HomeViewControllerDataSource: PostCellDelegate {
    
    func postCellDidSelectImage(_ image: UIImage) {
        provider?.homeViewControllerDidSelectImage(image)
    }
}
