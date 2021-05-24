//
//  CountriesListViewController.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import UIKit

enum CountryListMode {
    case filtered
    case complete
}

enum CountriesListViewControllerState {
    case idle
    case refeshing
    case loading
}

class CountriesListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    private var searchController: UISearchController!
    private var refreshControl: UIRefreshControl!
    
    private lazy var countryViewModel = CountryViewModel()
    private var listMode = CountryListMode.complete {
        didSet {
            tableView.reloadData()
        }
    }
    private var state: CountriesListViewControllerState? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchCountries()
    }
}

private extension CountriesListViewController {
    
    func configure() {
        title = "Countries"
        tableView.register(CountryTableViewCell.nib(), forCellReuseIdentifier: CountryTableViewCell.identifier)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search Countries"
        searchController.obscuresBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .orange
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
    }
    
    func updateUI() {
        guard let state = state else { return }
        switch state {
        case .idle:
            tableView.isHidden = false
            refreshControl.endRefreshing()
            hideActivityIndicator()
        case .loading:
            tableView.isHidden = true
            showActivityIndicator()
        case .refeshing:
            break
        }
        tableView.reloadData()
    }
    
    func fetchCountries() {
        state = refreshControl.isRefreshing ? .refeshing : .loading
        countryViewModel.fetchCountries { [weak self] _, errorDescription in
            self?.state = .idle
            if let message = errorDescription {
                self?.showRetryAlert(message: message, completion: {
                    self?.fetchCountries()
                })
            }
        }
    }
    
    @objc func refreshData() {
        listMode = .complete
        fetchCountries()
    }
    
    func showProvenances(_ country: Country?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let provenanceViewController = storyboard.instantiateViewController(withIdentifier: "ProvenanceViewController") as? ProvenanceViewController,
              let country = country else {
            return
        }
        provenanceViewController.setCountry(country)
        navigationController?.pushViewController(provenanceViewController, animated: true)
    }
    
}

extension CountriesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryViewModel.numberOfRows(listMode)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else {
            return CountryTableViewCell.init(style: .default, reuseIdentifier: CountryTableViewCell.identifier)
        }
        let country = countryViewModel.getCountry(indexPath.row, mode: listMode)
        cell.configure(country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countryViewModel.getCountry(indexPath.row, mode: listMode)
        showProvenances(country)
    }
}

extension CountriesListViewController: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        listMode = .filtered
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listMode = .complete
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if listMode != .filtered {
            listMode = .filtered
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            listMode = .complete
            return
        }
        countryViewModel.filterCountries(searchText)
        listMode = .filtered
    }
}
