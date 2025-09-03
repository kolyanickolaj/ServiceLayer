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
    }
}
