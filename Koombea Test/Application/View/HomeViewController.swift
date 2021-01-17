//
//  HomeViewController.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var postsTableView: UITableView!
    
    private let pullToRefresh = UIRefreshControl()
    private let router: MainRouterProtocol
    private let viewModel: HomeViewModelProtocol
    private let dataSource = HomeViewControllerDataSource()
    private let disposeBag = DisposeBag()
    
    init(viewModel: HomeViewModelProtocol, router: MainRouterProtocol) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
        self.title = "Posts"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
}

//MARK: - Private methods
private extension HomeViewController {
    
    func setupTableView() {
        dataSource.provider = viewModel
        postsTableView.registerCell(NormalPostCell.self)
        postsTableView.registerCell(LargePostCell.self)
        postsTableView.registerCell(ExtendedPostCell.self)
        postsTableView.dataSource = dataSource
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 460
        pullToRefresh.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        postsTableView.addSubview(pullToRefresh)
    }
    
    func setupViewModel() {
        viewModel
            .onAction
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .reloadData:
                    self?.pullToRefresh.endRefreshing()
                    self?.postsTableView.reloadData()
                case .showImage(let image):
                    self?.router.performTransition(transition: .showImageDetail(image), completion: nil)
                }
            })
            .disposed(by: disposeBag)
        viewModel.fetchPosts()
    }
    
    @objc func refreshTableView() {
        viewModel.fetchPosts()
    }
}
