//
//  ListNewsRouter.swift
//  NewsApp2
//
//  Created by Stella Patricia (ID) on 13/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Foundation

class ListNewsRouter: ListNewsRouterProtocol {
    static func initPresenter(vc: ViewController) -> ListNewsPresenterProtocol {
        let presenter: ListNewsPresenterProtocol & ListNewsInteractorOutputProtocol = ListNewsPresenter()
        let interactor: ListNewsInteractorInputProtocol = ListNewsInteractor()
        let router: ListNewsRouterProtocol = ListNewsRouter()
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return presenter
    }
}
