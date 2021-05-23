//
//  ProvenanceViewController.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import UIKit
import CoreLocation
import MapKit

enum ProvenanceViewControllerState {
    case idle
    case loading
}

class ProvenanceViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var mapView: MKMapView!
    private lazy var provenanceViewModel = ProvenanceViewModel()
    private var state: ProvenanceViewControllerState? {
        didSet {
            updateUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchProvenance()
    }
    
    func configure() {
        title = "Provenances"
        tableView.register(ProvenanceTableViewCell.nib(), forCellReuseIdentifier: ProvenanceTableViewCell.identifier)
    }
    
    func updateUI() {
        guard let state = state else { return }
        switch state {
        case .idle:
            tableView.isHidden = false
            mapView.isHidden = false
            hideActivityIndicator()
            updateMapView()
        case .loading:
            tableView.isHidden = true
            mapView.isHidden = true
            showActivityIndicator()
        }
        tableView.reloadData()
    }
    
    func fetchProvenance() {
        guard let country = provenanceViewModel.country else { return }
        state = .loading
        provenanceViewModel.fetchProvenances(for: country.id) { [weak self] in
            self?.state = .idle
        }
    }
    
    func setCountry(_ country: Country) {
        provenanceViewModel.country = country
    }
    
    func updateMapView(_ provenance: Provenance? = nil) {
        guard let country = provenanceViewModel.country else { return }
        var address = country.name
        if let provenance = provenance {
            address = provenance.name + ", " + address
        }
        CLGeocoder().geocodeAddressString(address) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first,
                  let region = placemark.region as? CLCircularRegion,
                  let location = placemark.location else {
                return
            }
            let mkRegion = MKCoordinateRegion(center: location.coordinate , latitudinalMeters: region.radius, longitudinalMeters: region.radius)
            self?.mapView.setRegion(mkRegion, animated: true)
        }
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
        guard let provenance = provenanceViewModel.getProvenance(indexPath.row) else { return }
        updateMapView(provenance)
    }

}

extension MKCoordinateRegion {
    public var mapRect: MKMapRect {
        let topLeft = MKMapPoint(CLLocationCoordinate2D(latitude: center.latitude + span.latitudeDelta/2, longitude: center.longitude - span.longitudeDelta/2))
        let bottomRight = MKMapPoint(CLLocationCoordinate2D(latitude: center.latitude - span.latitudeDelta/2, longitude: center.longitude + span.longitudeDelta/2))
        return MKMapRect(origin: MKMapPoint(x: min(topLeft.x, bottomRight.x), y: min(topLeft.y, bottomRight.y)),
                         size: MKMapSize(width: fabs(topLeft.x-bottomRight.x), height: fabs(topLeft.y-bottomRight.x)))
    }
}
