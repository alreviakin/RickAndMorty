//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Алексей Ревякин on 24.03.2023.
//

import Foundation
import Alamofire


class APIManager {
    static let shared = APIManager()
    
//    func getData(completion: @escaping ([Result])->Void) {
//        let request = AF.request("https://rickandmortyapi.com/api/character")
//        request.responseDecodable(of: CharactersAPI.self, completionHandler: { data in
//            guard let chatacters = data.value?.results else {return}
//            completion(chatacters)
//        })
//    }
    
    func getData(gender: String?, status: String?, name: String?, completion: @escaping ([Result])->Void) {
        var url = "https://rickandmortyapi.com/api/character"
        if let gender {
            url += "/?gender=" + gender
        }
        if !url.contains("?"), let status {
            url += "/?status=" + status
        } else if let status {
            url += "&status=" + status
        }
        if !url.contains("?"), let name {
            url += "/?name=" + name
        } else if let name {
            url += "&name=" + name
        }
        let request = AF.request(url)
        request.responseDecodable(of: CharactersAPI.self, completionHandler: { data in
            guard let chatacters = data.value?.results else {
                completion([])
                return
            }
            completion(chatacters)
        })
    }
}
