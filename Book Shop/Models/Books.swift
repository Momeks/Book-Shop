//
//  Books.swift
//  Book Shop
//
//  Created by Momeks on 12/23/21.
//

import Foundation

struct Book:Codable {
    
    var id:Int?
    var title:String?
    var summary:String?
    var coverURL:String?
    var author:String?
    var pages:Int?
    var publishDate:String?
    var publisher:String?
    
}


struct BookContents:Codable {
    var books:[Book]
}
