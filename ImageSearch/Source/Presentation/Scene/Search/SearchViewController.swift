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
    private let emptyResultLabel = UILabel()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        attribute()
    }
    
    // MARK: - Bind
    func bind(reactor: SearchReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Private Methods
    private func layout() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(emptyResultLabel)
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        emptyResultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func attribute() {
        collectionView.do {
            $0.rx.setDelegate(self)
                .disposed(by: self.disposeBag)
            $0.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.description())
            
            if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumLineSpacing = 0
                layout.minimumInteritemSpacing = 0
            }
        }
        
        emptyResultLabel.do {
            $0.text = "검색 결과가 없습니다."
            $0.isHidden = true
        }
    }
}

// MARK: - Bind Actions
private extension SearchViewController {
    func bindAction(reactor: SearchReactor) {
        bindSearchBar(reactor: reactor)
        bindScrollBottom(reactor: reactor)
        bindSelectImage(reactor: reactor)
    }
    
    func bindSearchBar(reactor: SearchReactor) {
        searchBar.rx.text.orEmpty
            .filter(\.isNotEmpty)
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .map(SearchReactor.Action.typeSearchText)
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func bindScrollBottom(reactor: SearchReactor) {
        collectionView.rx.bottom
            .throttle(.milliseconds(800), scheduler: MainScheduler.instance)
            .map { SearchReactor.Action.hitsBottom }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func bindSelectImage(reactor: SearchReactor) {
        collectionView.rx.itemSelected
            .map(SearchReactor.Action.selectImageAt)
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Bind States
private extension SearchViewController {
    func bindState(reactor: SearchReactor) {
        bindImages(reactor: reactor)
        bindErrorMesage(reactor: reactor)
        bindIsEmpty(reactor: reactor)
    }
    
    func bindImages(reactor: SearchReactor) {
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
    
    func bindErrorMesage(reactor: SearchReactor) {
        reactor.pulse(\.$alertMessage)
            .compactMap { $0 }
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: showAlert(message:))
            .disposed(by: self.disposeBag)
    }
    
    func bindIsEmpty(reactor: SearchReactor) {
        reactor.state.map(\.isEmpty)
            .map { !$0 }
            .asDriver(onErrorJustReturn: false)
            .drive(emptyResultLabel.rx.isHidden)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Collection View Delegate
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width / 3
        return CGSize(width: width, height: width)
    }
}
