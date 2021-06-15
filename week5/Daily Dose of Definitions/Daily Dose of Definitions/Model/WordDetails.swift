//
//  WordDetails.swift
//  Daily Dose of Definitions
//
//  Created by Rashid Goshtasbi on 6/11/21.
//

import Foundation

struct WordDetails: Decodable {
    let word: String?
    let results: [WordResult]?
}

struct WordResult: Decodable {
    let definition: String?
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
}
