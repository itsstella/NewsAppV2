//
//  ViewController.swift
//  NewsApp
//
//  Created by Stella Patricia (ID) on 09/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSource: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var indexOfPageToRequest = 1
    var keywordParam = ""
    var filterParam = ""
    var sourceParam = ""
    
    var sourceArray: [String] = []
    var presenter: ListNewsPresenterProtocol?
    let spinner = UIActivityIndicatorView(style: .gray)
    var dataNews: [NewsModel.ArticlesList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        
        UserDefaults.standard.set(false, forKey: "source")
        UserDefaults.standard.set("", forKey: "filter")
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = "NEWS"
        
        dataNews = []
        indexOfPageToRequest = 1
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()

        indexOfPageToRequest=1
        
        let filter = UserDefaults.standard.string(forKey: "filter")
        
        presenter = ListNewsRouter.initPresenter(vc: self)
        keywordParam = "gen"
        filterParam = filter ?? ""
        sourceParam = ""
        presenter?.fetchListNews(keyword: keywordParam, filter: filterParam, source: sourceParam, page: indexOfPageToRequest)
        
        changeColor()
    }
    
    func changeColor() {
        if (UserDefaults.standard.bool(forKey: "source")) {
            btnSource.backgroundColor = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0)
            btnCategory.backgroundColor = UIColor.gray
            tableView.estimatedRowHeight = 50.0
            tableView.rowHeight = UITableView.automaticDimension
        } else {
            btnCategory.backgroundColor = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0)
            btnSource.backgroundColor = UIColor.gray
            tableView.estimatedRowHeight = 120.0
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
    @IBAction func btnEnterClicked(_ sender: Any) {
        let vc = NewsFilterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchSourceClicked(_ sender: Any) {
        if searchTextField.text != "" {
            UserDefaults.standard.set(true, forKey: "source")
            changeColor()
            
            let sources = searchTextField.text ?? ""

            keywordParam = sources
            filterParam = ""
            sourceParam = ""
            presenter?.fetchListNews(keyword: keywordParam, filter: filterParam, source: sourceParam, page: 0)
        }
    }
    
    @IBAction func searchArticelsClicked(_ sender: Any) {
        if searchTextField.text != "" {
            UserDefaults.standard.set(false, forKey: "source")
            changeColor()
            
            let sources = searchTextField.text ?? ""
            
            keywordParam = sources
            filterParam = ""
            sourceParam = ""
            dataNews = []
            presenter?.fetchListNews(keyword: keywordParam, filter: filterParam, source: sourceParam, page: indexOfPageToRequest)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (UserDefaults.standard.bool(forKey: "source")){
            return sourceArray.count
        } else {
            return self.dataNews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (UserDefaults.standard.bool(forKey: "source")){
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "sourceCell")

               if (cell == nil) {
                   cell = SourceTableViewCell()
               }

            (cell as! SourceTableViewCell).sourceName.text = self.sourceArray[indexPath.row]

            
            return cell ?? UITableViewCell()
        } else {
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "ArticleCell")
               if (cell == nil) {
                   cell = ArticleTableViewCell()
               }

            (cell as! ArticleTableViewCell).lblTitle.text = self.dataNews[indexPath.row].title
            (cell as! ArticleTableViewCell).lblDesc.text = self.dataNews[indexPath.row].description
            
            (cell as! ArticleTableViewCell).imgArticle.kf.setImage(with: URL(string: self.dataNews[indexPath.row].urlToImage ?? ""))
            
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UserDefaults.standard.bool(forKey: "source")){
            return 50
        } else {
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (UserDefaults.standard.bool(forKey: "source")){
            dataNews = []
            indexOfPageToRequest = 1
            let sources = sourceArray[indexPath.row]
            
            let filter = UserDefaults.standard.string(forKey: "filter")
            
            keywordParam = "test"
            filterParam = filter ?? ""
            sourceParam = ""
            presenter?.fetchListNews(keyword: keywordParam, filter: filterParam, source: sourceParam, page: indexOfPageToRequest)
            UserDefaults.standard.set(false, forKey: "source")

            changeColor()

        } else {
            let vc = NewsDetailWebView()
            vc.stringUrl = dataNews[indexPath.row].url ?? ""
            present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !UserDefaults.standard.bool(forKey: "source"){
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            spinner.isHidden = false
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            
            let lastItem = (dataNews.count) - 1
            if indexPath.row == lastItem {
                presenter?.fetchListNews(keyword: keywordParam, filter: filterParam, source: sourceParam, page: indexOfPageToRequest)
            }
        }
    }
}

extension ViewController: ListNewsViewProtocol {
    func getData(data: NewsModel) {
        if UserDefaults.standard.bool(forKey: "source"){
           dataNews = []
        }
        self.sourceArray = []
        
        for item in data.articles ?? [] {
            self.dataNews.append(item)
        }
        
        for item in self.dataNews {
            self.sourceArray.append(item.source?.name ?? "")
        }
        
        self.sourceArray = self.uniq(source: self.sourceArray)
        
        indexOfPageToRequest += 1
        
        spinner.isHidden = true
        self.tableView.reloadData()
    }
    
    func getError() {
        spinner.isHidden = true
        self.tableView.reloadData()
    }
}
