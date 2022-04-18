//
//  Books.swift
//  Book Shop
//
//  Created by Momeks on 12/23/21.
//

import Foundation

struct Book: Codable {
   let id: Int?
   let title: String?
   let summary: String?
   let coverURL: String?
   let author: String?
   let pages: Int?
   let publishDate: String?
   let publisher: String?
   let color: String?
}

struct BookContents: Codable {
    let books: [Book]
}
