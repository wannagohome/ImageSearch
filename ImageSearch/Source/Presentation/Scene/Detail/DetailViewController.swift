//
//  DetailViewController.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let model: ImageModel
    
    // MARK: - Views
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let metaDataLabel = UILabel()
    
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
        view.addSubview(metaDataLabel)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        metaDataLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-80)
            make.centerX.equalToSuperview()
        }
    }
    
    private func attribute() {
        view.backgroundColor = .systemBackground
        
        imageView.do {
            $0.kf.setImage(with: model.imageURL)
            $0.contentMode = .scaleAspectFill
        }
        metaDataLabel.do {
            $0.backgroundColor = .white
            $0.font = .boldSystemFont(ofSize: 15)
            $0.numberOfLines = 0
            $0.text = """
                    출처 : \(model.displaySitename)
                    문서 작성 시간 : \(model.datetime)
                    """
        }
    }
}
