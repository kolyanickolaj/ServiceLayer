//
//  PaymentMethod.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

public struct PaymentMethod: Codable, JSONParsable  {
    public let id: String
    public let name: String
}
