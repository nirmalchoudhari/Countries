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
    private var listMode = CountryListMode.complete
    private var state: CountriesListViewControllerState? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadCountries()
    }
    
    func configure() {
        title = "Countries"
        tableView.register(CountryTableViewCell.nib(), forCellReuseIdentifier: CountryTableViewCell.identifier)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
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
    
    func loadCountries() {
        state = refreshControl.isRefreshing ? .refeshing : .loading
        countryViewModel.fetchCountries { [weak self] in
            self?.state = .idle
        }
    }
    
    @objc func refreshData() {
        listMode = .complete
        loadCountries()
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let provenanceViewController = storyboard.instantiateViewController(withIdentifier: "ProvenanceViewController") as? ProvenanceViewController,
              let country = countryViewModel.getCountry(indexPath.row, mode: listMode) else {
            return
        }
        provenanceViewController.setCountry(country)
        navigationController?.pushViewController(provenanceViewController, animated: true)
    }
}

extension CountriesListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        countryViewModel.filterCountries(searchText)
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        listMode = .filtered
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listMode = .complete
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if listMode != .filtered {
            listMode = .filtered
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            listMode = .complete
            return
        }
        listMode = .filtered
        countryViewModel.filterCountries(searchText)
        tableView.reloadData()
    }
}
