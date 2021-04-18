//
//  AuthenticationLocalDatasource.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation

class AuthenticationLocalDatasource: LocalDatasource {
    
    static let shared = AuthenticationLocalDatasource()
    
}

// MARK: - Logging User
extension AuthenticationLocalDatasource {

    func cacheUser(_ user: UserModel?) {
        removeAppUserFileName()
        guard let user = user else {
            print("Delete App User successful")
            return
        }
        do {
            let data = try PropertyListEncoder().encode(user)
            let fileName = StoredFile.appUserFile.rawValue
            let success = LocalFileManager.shared.saveData(data, fileName: fileName)
            if success {
                print("Save App User successful")
            } else {
                print("Save App User failed")
            }
        } catch {
            print("Save App User failed")
        }
    }

    func getCachedUser() -> UserModel? {
        guard let savedData = LocalFileManager.shared.getData(with: StoredFile.appUserFile.rawValue) else {
            return nil
        }
        do {
            let result = try PropertyListDecoder().decode(UserModel.self, from: savedData)
            return result
        } catch {
            return nil
        }
    }

    func removeAppUserFileName() {
        LocalFileManager.shared.removeFile(with: StoredFile.appUserFile.rawValue)
    }
    
    var isAuthorized: Bool {
        return getCachedUser() != nil
    }
    
}
