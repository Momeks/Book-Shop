//
//  PLISTDataSerivce.swift
//  Book Shop
//
//  Created by Momeks on 12/26/21.
//

import UIKit

class PLISTDataSerivce {

    static let shared = PLISTDataSerivce()
    
    func getDataFrom(plist:String) -> [Book] {
        let url = Bundle.main.url(forResource: plist, withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode([Book].self, from: data)
    }
    
    
    
    func lookForBookWith(id:Int) -> Book {
        
        let url = Bundle.main.url(forResource: "Best Seller", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        let bestSeller =  try! decoder.decode([Book].self, from: data)
        
        let url2 = Bundle.main.url(forResource: "New Arrival", withExtension: "plist")!
        let data2 = try! Data(contentsOf: url2)
        let decoder2 = PropertyListDecoder()
        let newArrival = try!  decoder2.decode([Book].self, from: data2)
        
        //Merge All Data
        let mergeData =  bestSeller + newArrival
    
        return mergeData.first(where: {$0.id == id})!
    }
    
    
}
