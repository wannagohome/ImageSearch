//
//  ViewController.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/03/31.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    // MARK: Views
    private let searchBar = UISearchBar()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }

    // MARK: - Private Methods
    private func layout() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

