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
    var initialState: State
    private let usercase: ImageUseCaseType
    
    init(usecase: ImageUseCaseType) {
        self.initialState = State()
        self.usercase = usecase
    }
    
    // MARK: - Reactor
    enum Action {
        case typeSearchText(String)
        case hitsBottom
        case selectImageAt(IndexPath)
    }
    
    enum Mutation {
        case setImages([ImageModel])
        case appendImages([ImageModel])
    }
    
    struct State {
        var images: [ImageModel] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .typeSearchText(let str) :
            return usercase.search(query: str)
                .do(onError: { err in
                    // TODO: handle error
                })
                .asObservable()
                .map(Mutation.setImages)
            
        case .hitsBottom:
            return usercase.loadNextPage()
                .do(onError: { err in
                    // TODO: handle error
                })
                .asObservable()
                .map(Mutation.appendImages)
            
        case .selectImageAt:
            // TODO: make function
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setImages(let models):
            newState.images = models
            
        case .appendImages(let models):
            newState.images.append(contentsOf: models)
        }
        
        return newState
    }
}
