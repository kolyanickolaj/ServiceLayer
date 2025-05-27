//
//  MDProducer.swift
//  CasinoTool
//
//  Created by Andrey Polyashev on 9/28/22.
//

import Foundation
import SwiftyJSON

 struct Producer: Codable, JSONParsable {
     let id: Int
     let name: String
     let text: String?
     let title: String?
     let logoUrl: URL?
          
     static func from(_ json: JSON) -> Producer? {
         guard
            let id = json["id"].int,
            let name = json["name"].string
         else { return nil}
         let title = json["title"].string
         let text = json["text"].string
         
         let logoUrlString = json["logoUrl"].string?.replacingOccurrences(of: ".svg", with: ".png")
         var logoUrl: URL?
         if let logoUrlString {
             logoUrl = URL(string: logoUrlString)
         }
         return .init(id: id, name: name, text: text, title: title, logoUrl: logoUrl)
     }
}
