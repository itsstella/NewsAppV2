//
//  ListNewsInteractor.swift
//  NewsApp2
//
//  Created by Stella Patricia (ID) on 13/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ListNewsInteractor: ListNewsInteractorInputProtocol {
    var presenter: ListNewsInteractorOutputProtocol?
    
    func callRequest(keyword: String, filter: String, source: String, page: Int) {
        var url = "https://newsapi.org/v2/everything?q="+keyword+"&apiKey=a3a647d1ef0e45299bea6ba279179895"
        
        if page>0 && !UserDefaults.standard.bool(forKey: "source"){
            url = "https://newsapi.org/v2/everything?q="+keyword+"&apiKey=a3a647d1ef0e45299bea6ba279179895&pageSize=10&page="+String(page)
        }
        
        if filter != "" {
            if page > 0 {
                url = "https://newsapi.org/v2/top-headlines?category="+filter+"&apiKey=a3a647d1ef0e45299bea6ba279179895&pageSize=10&page="+String(page)
            } else {
                url = "https://newsapi.org/v2/top-headlines?category="+filter+"&apiKey=a3a647d1ef0e45299bea6ba279179895"
            }
        }
        
        if source != "" {
            url = "https://newsapi.org/v2/everything?sources="+source+"&apiKey=a3a647d1ef0e45299bea6ba279179895"
        }
        
        Alamofire.request(url).responseObject { (response: DataResponse<NewsModel>) in
            if(response.response?.statusCode == 200){
                let newsResponse = response.result.value
                self.presenter?.requestSuccess(data: newsResponse)
            }else {
                self.presenter?.requestFailed()
            }
        }
    }
        
}
    
    

