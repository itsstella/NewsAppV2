//
//  File.swift
//  NewsApp2
//
//  Created by Stella Patricia (ID) on 14/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Foundation
import UIKit

protocol NewsFilterPresenterProtocol: class{
    var view: NewsFilterViewProtocol? { get set }
    var interactor: NewsFilterInteractorInputProtocol? { get set }
    var router: NewsFilterRouterProtocol? { get set }
    func fetchNewsFilter()

}

protocol NewsFilterViewProtocol: class {
    func getData(data: SourcesModel)
    func getError()
}

protocol NewsFilterInteractorOutputProtocol: class {
    func requestSuccess(data: SourcesModel?)
    func requestFailed()
}

protocol NewsFilterInteractorInputProtocol: class {
    var presenter: NewsFilterInteractorOutputProtocol? { get set }
    func callRequest()
}

protocol NewsFilterRouterProtocol: class {
    static func initPresenter(vc: NewsFilterViewController) -> NewsFilterPresenterProtocol
}
