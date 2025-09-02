//
//  DocumentUploadRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 29.08.25.
//

import Foundation

struct FileUpload: Codable {
    struct FileData: Codable {
        let name: String
        let data: String
    }
    let file: FileData
}

final class DocumentUploadRequest: BaseRequest, ModelRequest {
    typealias Model = Document
    
    struct Query: Codable {
        let imageName: String
        let imageData: Data
    }
    
    private let queries: Query
    
    var zone: RequestZone {
        .private
    }
    
    var method: HTTP.Method {
        .POST
    }

    var path: String {
        "user/documents/upload/v2"
//        api/user/documents/upload/v2?_trlang=en
    }
    
    var apiVersion: ApiVersion {
        .api
    }
    
    var payloadKey: String? {
        "data.item"
    }
    
    init(queries: Query) {
        self.queries = queries
    }
    
    func makeBody() throws -> Data? {
        let upload = FileUpload(file: .init(name: queries.imageName, data: queries.imageData.base64EncodedString()))
        return try JSONEncoder().encode(upload)
//            let jsonData = try JSONEncoder().encode(upload)
////        let encoder = JSONEncoder()
////        return try encoder.encode(queries)
//        var components = URLComponents()
//        components.queryItems = [
//            .init(name: "email_marketing_allowed", value: "\(queries.isEmailAllowed)"),
//            .init(name: "notificationsEnabled", value: "\(queries.notificationsEnabled)")
//        ]
//        return components.percentEncodedQuery?.data(using: .utf8)
    }
}
