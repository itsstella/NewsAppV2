//
//  NewsFilterInteractor.swift
//  NewsApp2
//
//  Created by Stella Patricia (ID) on 14/06/20.
//  Copyright © 2020 Stella. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class NewsFilterInteractor: NewsFilterInteractorInputProtocol {
    var presenter: NewsFilterInteractorOutputProtocol?
    
    func callRequest() {
        let url = "https://newsapi.org/v2/sources?apiKey=a3a647d1ef0e45299bea6ba279179895"
        
        
        Alamofire.request(url).responseObject { (response: DataResponse<SourcesModel>) in
            if(response.response?.statusCode == 200){
                let newsResponse = response.result.value
                self.presenter?.requestSuccess(data: newsResponse)
            }else {
                self.presenter?.requestFailed()
            }
        }
    }
        
}
    
    

