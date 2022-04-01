//
//  ImageCell.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import UIKit
import Kingfisher

final class ImageCell: UICollectionViewCell {
    
    // MARK: - Views
    private let imageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleToFill
    }
    
    // MARK: - Initalization
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setImageWith(url: URL) {
        imageView.kf.setImage(with: url)
    }
    
    
    // MARK: - Private Methods
    private func layout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
