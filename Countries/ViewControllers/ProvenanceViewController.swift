//
//  ProvenanceViewController.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import UIKit

class ProvenanceViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    private lazy var provenanceViewModel = ProvenanceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        guard let country = provenanceViewModel.country else { return }
        provenanceViewModel.fetchProvenances(for: country.id) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configure() {
        tableView.register(ProvenanceTableViewCell.nib(), forCellReuseIdentifier: ProvenanceTableViewCell.identifier)
    }
    
    func setCountry(_ country: Country) {
        provenanceViewModel.country = country
    }
}

extension ProvenanceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provenanceViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProvenanceTableViewCell.identifier, for: indexPath) as? ProvenanceTableViewCell else {
            return ProvenanceTableViewCell.init(style: .default, reuseIdentifier: ProvenanceTableViewCell.identifier)
        }
        
        let provenance = provenanceViewModel.getProvenance(indexPath.row)
        cell.configure(provenance)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
