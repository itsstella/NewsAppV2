//
//  NewsListPresenter.swift
//  NewsApp2
//
//  Created by Stella Patricia (ID) on 13/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Foundation

class ListNewsPresenter: ListNewsPresenterProtocol {
    var view: ListNewsViewProtocol?
    
    var interactor: ListNewsInteractorInputProtocol?
    
    var router: ListNewsRouterProtocol?
    
    func fetchListNews(keyword: String, filter: String, source: String, page: Int) {
        interactor?.callRequest(keyword: keyword, filter: filter, source: source, page: page)
    }
}

extension ListNewsPresenter: ListNewsInteractorOutputProtocol {
    func requestSuccess(data: NewsModel?) {
        if let data = data {
            view?.getData(data: data)
        }
    }
    
    func requestFailed() {
        view?.getError()
    }
}
