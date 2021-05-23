//
//  CountriesListViewController.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import UIKit

class CountriesListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    private lazy var countryViewModel = CountryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        countryViewModel.fetchCountries {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func configure() {
        title = "COUNTIRES"
        tableView.register(CountryTableViewCell.nib(), forCellReuseIdentifier: CountryTableViewCell.identifier)
    }
}

extension CountriesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else {
            return CountryTableViewCell.init(style: .default, reuseIdentifier: CountryTableViewCell.identifier)
        }
        let country = countryViewModel.getCountry(indexPath.row)
        cell.configure(country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let provenanceViewController = storyboard.instantiateViewController(withIdentifier: "ProvenanceViewController") as? ProvenanceViewController,
              let country = countryViewModel.getCountry(indexPath.row) else {
            return
        }
        provenanceViewController.setCountry(country)
        navigationController?.pushViewController(provenanceViewController, animated: true)
    }
}
