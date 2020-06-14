//
//  NewsFilterRouter.swift
//  NewsApp2
//
//  Created by Stella Patricia (ID) on 14/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Foundation

class NewsFilterRouter: NewsFilterRouterProtocol {
    static func initPresenter(vc: NewsFilterViewController) -> NewsFilterPresenterProtocol {
        let presenter: NewsFilterPresenterProtocol & NewsFilterInteractorOutputProtocol = NewsFilterPresenter()
        let interactor: NewsFilterInteractorInputProtocol = NewsFilterInteractor()
        let router: NewsFilterRouterProtocol = NewsFilterRouter()
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return presenter
    }
}
