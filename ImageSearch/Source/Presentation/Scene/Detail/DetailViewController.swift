//
//  DetailViewController.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Views
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let model: ImageModel
    
    // MARK: - Initialization
    init(model: ImageModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    // MARK: - Private Methods
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func attribute() {
        view.backgroundColor = .systemBackground
        imageView.kf.setImage(with: model.imageURL)
        imageView.contentMode = .scaleAspectFill
    }
}
