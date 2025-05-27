//
//  MDGameResponse.swift
//  CasinoTool
//
//  Created by Andrey Polyashev on 9/28/22.
//

import Foundation

struct MDGameResponse: Codable {
    let status: String
    let code: Int
    let data: MDGameData
}
