//
//  BookCovers.swift
//  Book Shop
//
//  Created by Momeks on 12/26/21.
//


import Foundation
import UIKit

class BookCovers {
    
    static let shared = BookCovers()
    var cover:UIImage?
    var backCover:UIImage?
    var sideCover:UIImage?
    

    func sideCover(title:String, color:String) -> UIImage {
        
        let sideCover = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 1700))
        sideCover.backgroundColor = hexToColor(hex: color)
        //sideCover.center = view.center
        
        let btitle = UILabel(frame: CGRect(x: 0, y: 0, width: sideCover.frame.height - 200, height: sideCover.frame.width - 200 ))
        btitle.center = sideCover.center
        btitle.adjustsFontSizeToFitWidth = true
        btitle.text = title
        btitle.textAlignment = .center
        btitle.font = UIFont(name: "Georgia-Bold", size: 50)
        btitle.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
      
        sideCover.addSubview(btitle)
        
        UIGraphicsBeginImageContextWithOptions(sideCover.frame.size, true, 0.0)
        if let context = UIGraphicsGetCurrentContext() { sideCover.layer.render(in: context) }
        let screenshot: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return screenshot!
        
    }
    
    
    
    func backCover(title:String, author:String, description:String, color:String) -> UIImage {
        
        let backCover = UIView(frame: CGRect(x: 0 , y: 0, width: 574, height: 871))

        backCover.backgroundColor = hexToColor(hex: color)

        let btitle = UILabel(frame: CGRect(x: 0, y: 0, width: backCover.frame.width - 70, height: 250))
        btitle.adjustsFontSizeToFitWidth = true
        btitle.center = CGPoint(x: backCover.frame.midX, y: 320)
        btitle.text = title
        btitle.numberOfLines = 2
        btitle.textAlignment = .center
        btitle.font = UIFont(name: "Georgia-Bold", size: 40)
    

        let bauthor = UILabel(frame: CGRect(x: 0, y: 0, width: backCover.frame.width, height: 90))
        bauthor.text = "By \(author)"
        bauthor.textAlignment = .center
        bauthor.center = CGPoint(x: backCover.frame.midX, y: btitle.center.y + 70)
        bauthor.font = UIFont(name: "Georgia-Italic", size: 20)
        
        
        let descriptions = UITextView(frame: CGRect(x: 0, y: 0, width: backCover.frame.width - 70, height: 200))
        descriptions.center = CGPoint(x: backCover.frame.midX, y: bauthor.center.y + 150)
        descriptions.text = description
        descriptions.font = UIFont.systemFont(ofSize: 15)
        descriptions.textAlignment = .center
        descriptions.backgroundColor = .clear
        
        backCover.addSubview(descriptions)
        backCover.addSubview(btitle)
        backCover.addSubview(bauthor)
        
        
        UIGraphicsBeginImageContextWithOptions(backCover.frame.size, true, 0.0)
        if let context = UIGraphicsGetCurrentContext() { backCover.layer.render(in: context) }
        let screenshot: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot!
        
    }

    
    
    private func hexToColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
}


