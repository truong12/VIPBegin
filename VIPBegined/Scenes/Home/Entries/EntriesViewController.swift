//
//  EntriesViewController.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import UIKit

class EntriesViewController: BaseViewController {

    fileprivate var interactor: EntriesInteractor!
    fileprivate var router: EntriesRouter!

    @IBOutlet fileprivate weak var naviView: NaviBarView!

    @IBOutlet fileprivate weak var countryLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var capitalLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var countryButton: BaseBorderButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func setupLogicLayers() {
        interactor = EntriesInteractor()
        router = EntriesRouter()
        let presenter = EntriesPresenter()
        presenter.view = self
        presenter.router = router
        router.navigationController = self.navigationController
        interactor.presenter = presenter
    }

    override func performLocalizeTexts() {
        naviView.naviTitle = "entries.navi.title".localized
    }

}

// MARK: View
extension EntriesViewController: EntriesDisplayLogic {
    func displayCountry(_ country: CountryModel) {
        countryButton.hideLoading()
        countryLabel.text = country.name
        capitalLabel.text = country.capital.name
    }
}

// MARK: Action
extension EntriesViewController {
    @IBAction fileprivate func getCountryAction(_ sender: Any) {
        countryButton.showLoading()
        countryLabel.text = "-"
        capitalLabel.text = "-"
        interactor.getCountry()
    }
}
