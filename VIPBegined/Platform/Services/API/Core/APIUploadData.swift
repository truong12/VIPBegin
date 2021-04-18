//
//  APIUploadData.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation

class APIUploadData {

    var fileURL: URL?
    var data: Data?
    var name = ""
    var fileName = ""
    var mimeType = ""

    init(fileURL: URL, name: String, fileName: String, mimeType: String) {
        self.fileURL = fileURL
        initWith(name: name, fileName: fileName, mimeType: mimeType)
    }

    init(data: Data, name: String, fileName: String, mimeType: String) {
        self.data = data
        initWith(name: name, fileName: fileName, mimeType: mimeType)
    }

    fileprivate func initWith(name: String, fileName: String, mimeType: String) {
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

extension APIUploadData {
    
    static func getAvatarData(_ data: Data) -> APIUploadData {
        return APIUploadData(data: data, name: "file", fileName: "file.jpg", mimeType: "image/jpg")
    }
}
