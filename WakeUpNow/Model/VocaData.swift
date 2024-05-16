//
//  VocaData.swift
//  WakeUpNow
//
//  Created by SAMSUNG on 5/13/24.
//

import Foundation
import UIKit

struct Words: Codable,Equatable {
    let word: String
    let meaning: String
    let furigana: String
    let romaji: String
    let level: Int
}

