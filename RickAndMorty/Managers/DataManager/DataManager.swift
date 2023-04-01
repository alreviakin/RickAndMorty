//
//  DataManager.swift
//  RickAndMorty
//
//  Created by Алексей Ревякин on 31.03.2023.
//

import Foundation
import Alamofire

class DataManger {
    static let shared = DataManger()
    
    func getData(gender: String? = nil, status: String? = nil, name: String? = nil, completion: @escaping (([Result], [Data]))->Void){
        var characters: [Result] = []
        var imageData: [Data] = []
        let group = DispatchGroup()
        group.enter()
        APIManager.shared.getData(gender: gender, status: status, name: name) { response in
            characters = response
            group.leave()
        }
        group.notify(queue: .main) {
            for character in characters {
                group.enter()
                if let imageStringURL = character.image {
                    AF.request(imageStringURL).response { response in
                        switch response.result {
                        case.success(let data):
                            if let data = data {
                                imageData.append(data)
                            }
                        case .failure(let error):
                            print("Error -> ", error)
                        }
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                completion((characters, imageData))
            }
            
        }
        
    }
}
