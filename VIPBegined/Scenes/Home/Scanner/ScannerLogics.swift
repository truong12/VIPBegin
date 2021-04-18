//
//  ScannerLogics.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import Foundation

// MARK: DisplayLogic
protocol ScannerDisplayLogic: DisplayLogic {
    func displayUser(_ user: UserModel)
}

// MARK: BusinessLogic
protocol ScannerBusinessLogic: BusinessLogic {

    var presenter: ScannerPresentationLogic? { get set }

    func getUser()
    func getFarmerFromQRCode(_ qrCode: String)

}

// MARK: PresentationLogic
protocol ScannerPresentationLogic: PresentationLogic {

    var view: ScannerDisplayLogic? { get set }
    var router: ScannerRoutingLogic? { get set }

    func getUserSuccess(_ user: UserModel)
}

// MARK: RoutingLogic
protocol ScannerRoutingLogic: RoutingLogic {
    
    var interactor: ScannerBusinessLogic? { get set }

    func goToQRCodeScreen()
}
