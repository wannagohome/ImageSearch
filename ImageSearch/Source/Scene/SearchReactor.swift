//
//  SearchReactor.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import ReactorKit
import Foundation

final class SearchReactor: Reactor {
    // MARK: - Properties
    var initialState: State = State()
    
    // MARK: - Reactor
    enum Action {
        case typeSearchText(String)
        case hitsBottom
        case selectImageAt(IndexPath)
    }
    
    struct State {
        
    }
}
