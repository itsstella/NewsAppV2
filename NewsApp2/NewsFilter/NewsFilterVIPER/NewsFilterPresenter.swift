//
//  NewsFilterPresenter.swift
//  NewsApp2
//
//  Created by Stella Patricia (ID) on 14/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Foundation

class NewsFilterPresenter: NewsFilterPresenterProtocol {
    var view: NewsFilterViewProtocol?
    
    var interactor: NewsFilterInteractorInputProtocol?
    
    var router: NewsFilterRouterProtocol?
    
    func fetchNewsFilter() {
        interactor?.callRequest()
    }
}

extension NewsFilterPresenter: NewsFilterInteractorOutputProtocol {
    func requestSuccess(data: SourcesModel?) {
        if let data = data {
            view?.getData(data: data)
        }
    }
    
    func requestFailed() {
        view?.getError()
    }
}
