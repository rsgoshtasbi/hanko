//
//  User.swift
//  AlamofireExample
//
//  Created by Rashid Goshtasbi on 6/12/21.
//

import Foundation

struct User: Decodable {

    //    let name: String
        
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case id = "id"
    }
    
    let fullName: String
    let id: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try container.decode(String.self, forKey: .fullName)
        id = try container.decode(Int.self, forKey: .id)
    }
}
