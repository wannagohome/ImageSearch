//
//  ViewController.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/03/31.
//

import UIKit
import SnapKit
import ReactorKit
import Then
import RxCocoa

final class SearchViewController: UIViewController, View {
    
    // MARK: - Properties
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Views
    private let searchBar = UISearchBar()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then { collectionView in
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.description())
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    // MARK: - Private Methods
    private func layout() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Bind
extension SearchViewController {
    func bind(reactor: SearchReactor) {
        bindAction(reactor: reactor)
    }
    
    private func bindAction(reactor: SearchReactor) {
        bindSearchBar(reactor: reactor)
    }
    
    private func bindSearchBar(reactor: SearchReactor) {
        searchBar.rx.text.orEmpty
            .throttle(.seconds(1), scheduler: MainScheduler()).debug()
            .map(SearchReactor.Action.typeSearchText)
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func bindCollectionView(reactor: SearchReactor) {
        reactor.state.map(\.images)
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items) { cv, row, item in
                let cell = cv.dequeueReusableCell(
                    withReuseIdentifier: ImageCell.description(),
                    for: IndexPath(row: row, section: 0)
                ) as! ImageCell
                cell.setImageWith(url: item.thumbnailURL)
                return cell
            }
            .disposed(by: self.disposeBag)
    }
}

