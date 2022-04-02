//
//  SearchViewPresenter.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import UIKit

protocol SearchViewPresenter: UIViewController {
    func presentDetail(model: ImageModel)
    func showAlert(message: String)
}

extension SearchViewController: SearchViewPresenter {
    func presentDetail(model: ImageModel) {
        navigationController?
            .pushViewController(
                DetailViewController(model: model),
                animated: true
            )
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .destructive))
        self.present(alert, animated: true)
    }
}
