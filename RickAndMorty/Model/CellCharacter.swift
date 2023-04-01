//
//  Characters.swift
//  RickAndMorty
//
//  Created by Алексей Ревякин on 22.03.2023.
//

import Foundation
import UIKit

enum Status: String {
    case alive
    case dead
    case unknown
}

struct CellCharacter {
    var image: UIImage
    var name: String
    var type: String
    var status: Status
}
