//
//  SearchViewPresenterMock.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/03.
//

import UIKit
@testable import ImageSearch

class SearchViewPresenterMock: UIViewController, SearchViewPresenter {
    var alertMessage: String?
    var imageModel: ImageModel?
    
    func presentDetail(model: ImageModel) {
        self.imageModel = model
    }
    
    func showAlert(message: String) {
        self.alertMessage = message
    }
}
