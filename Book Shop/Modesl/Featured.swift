//
//  Featured.swift
//  Book Shop
//
//  Created by Momeks on 12/23/21.
//

import Foundation

struct Featured:Codable {
    var title:String?
    var id:String?
}

struct FeaturedContents:Codable {
    var featureds:[Featured]
}
