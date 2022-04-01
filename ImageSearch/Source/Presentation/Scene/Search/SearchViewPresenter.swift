//
//  SearchViewPresenter.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import UIKit

protocol SearchViewPresenter: UIViewController {
    func presentDetail(model: ImageModel)
}

extension SearchViewController: SearchViewPresenter {
    func presentDetail(model: ImageModel) {
        navigationController?
            .pushViewController(
                DetailViewController(model: model),
                animated: true
            )
    }
}
