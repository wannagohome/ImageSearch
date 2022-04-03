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
    weak var presenter: SearchViewPresenter?
    
    init(usecase: ImageUseCaseType,
         presenter: SearchViewPresenter) {
        self.initialState = State()
        self.usercase = usecase
        self.presenter = presenter
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
        case setErrorMetssage(String)
    }
    
    struct State {
        var images: [ImageModel] = []
        var isEmpty = false
        @Pulse var alertMessage: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .typeSearchText(let str):
            return usercase.search(query: str)
                .asObservable()
                .map(Mutation.setImages)
                .catch { .just(.setErrorMetssage($0.localizedDescription)) }
            
        case .hitsBottom:
            guard !currentState.images.isEmpty else {
                return .empty()
            }
            return usercase.loadNextPage()
                .asObservable()
                .map(Mutation.appendImages)
                .catch { .just(.setErrorMetssage($0.localizedDescription)) }
            
        case .selectImageAt(let indexPath):
            if indexPath.row < currentState.images.count {
                let imageModel = currentState.images[indexPath.row]
                self.presenter?.presentDetail(model: imageModel)
            }
            
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setImages(let models):
            newState.isEmpty = models.isEmpty
            newState.images = models
            
        case .appendImages(let models):
            newState.images.append(contentsOf: models)
            
        case .setErrorMetssage(let msg):
            newState.alertMessage = msg
        }
        
        return newState
    }
}
