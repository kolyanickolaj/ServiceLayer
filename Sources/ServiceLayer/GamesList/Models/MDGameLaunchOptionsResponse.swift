//
//  MDG.swift
//  CasinoTool
//
//  Created by Andrey Polyashev on 9/28/22.
//

import Foundation

 struct MDGameLaunchOptionsResponse: Codable {
     let status: String
     let code: Int
     let data: MDGameLaunchOptionsData
}
