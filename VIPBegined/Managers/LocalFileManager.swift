//
//  LocalFileManager.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation

final class LocalFileManager {

    static let shared = LocalFileManager()

}

extension LocalFileManager {

    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first ?? NSTemporaryDirectory()
    }
    
}

// MARK: - Save into document directory
extension LocalFileManager {

    func saveData(_ data: Data, fileName: String) -> Bool {
        let path = documentsDirectory()
        return saveData(data, fileName: fileName, atPath: path)
    }

    fileprivate func saveData(_ data: Data, fileName: String, atPath path: String) -> Bool {
        let newPath = NSString(string: path).appendingPathComponent(fileName)
        FileManager.default.createFile(atPath: newPath, contents: nil, attributes: nil)
        if FileManager.default.isWritableFile(atPath: newPath) {
            do {
                try data.write(to: URL(fileURLWithPath: newPath))
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    func getData(with name: String) -> Data? {
        let path = getDataPath(with: name)
        return FileManager.default.contents(atPath: path)
    }
    
    func getDataPath(with name: String) -> String {
        let path = documentsDirectory()
        let dataPath = NSString(string: path).appendingPathComponent(name)
        return dataPath
    }

    func createNewDirectory(with path: String) -> Bool {
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true,
                                                        attributes: nil)
                return true
            } catch {
                return false
            }
        }
        return false
    }

    func removeFile(with name: String) {
        let path = getDataPath(with: name)
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {

            }
        }
    }
}
