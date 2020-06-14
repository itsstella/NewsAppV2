//
//  NewsListProtocol.swift
//  NewsApp2
//
//  Created by Stella Patricia (ID) on 13/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Foundation
import UIKit

protocol ListNewsPresenterProtocol: class{
    var view: ListNewsViewProtocol? { get set }
    var interactor: ListNewsInteractorInputProtocol? { get set }
    var router: ListNewsRouterProtocol? { get set }
    func fetchListNews(keyword: String, filter: String, source: String, page: Int)

}

protocol ListNewsViewProtocol: class {
    func getData(data: NewsModel)
    func getError()
}

protocol ListNewsInteractorOutputProtocol: class {
    func requestSuccess(data: NewsModel?)
    func requestFailed()
}

protocol ListNewsInteractorInputProtocol: class {
    var presenter: ListNewsInteractorOutputProtocol? { get set }
    func callRequest(keyword: String, filter: String, source: String, page: Int)
}

protocol ListNewsRouterProtocol: class {
    static func initPresenter(vc: ViewController) -> ListNewsPresenterProtocol
}
