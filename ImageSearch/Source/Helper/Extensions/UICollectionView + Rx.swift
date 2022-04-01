//
//  UICollectionView + Rx.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base == UICollectionView {
    var bottom: Observable<Void> {
        base.rx.didScroll
            .filter {
                base.contentOffset.y
                >= (base.contentSize.height - base.frame.size.height)
            }
    }
}
