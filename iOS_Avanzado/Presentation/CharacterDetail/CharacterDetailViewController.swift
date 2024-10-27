//
//  CharacterDetailViewController.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 26/10/24.
//

import UIKit
import MapKit

class CharacterDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let viewModel: CharacterDetailViewModel
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var locationManager: CLLocationManager = CLLocationManager()

    
    init(_ viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CharacterDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.character.name
        configureMap()
        bind()
        checkLocationAuthorizationStatus()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(TransformationsCollectionViewCell.nib, forCellWithReuseIdentifier: TransformationsCollectionViewCell.reuseIdentifier)
        
        viewModel.load()
    }
    
    private func configureMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsUserTrackingButton = true
    }
    
    func bind(){
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .loading:
                self?.caseLoading()
            case .ready:
                self?.caseReady()
            case .locationsReady:
                self?.caseLocationsReady()
            case .transformationsReady:
                self?.caseTransformationsReady()
            case .error(let reason):
                self?.caseError(reason)
            }
        }
    }
    
    private func checkLocationAuthorizationStatus() {
        let authorizationStatus = locationManager.authorizationStatus
        switch authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            mapView.showsUserLocation = false
            mapView.showsUserTrackingButton = false
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    private func caseLoading() {
        
    }
    
    private func caseReady() {
        characterDescription.text = viewModel.character.description
        //TODO: assign character name
    }
    
    private func caseTransformationsReady() {
        collectionView.reloadData()
    }
    
    private func caseLocationsReady() {
        let oldAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(oldAnnotations)
        self.mapView.addAnnotations(viewModel.annotations)
        
        if let annotaion = viewModel.annotations.first {
            mapView.region = MKCoordinateRegion(center: annotaion.coordinate,
                                                latitudinalMeters: 100000,
                                                longitudinalMeters: 100000)
        }

    }
    
    private func caseError(_ reason: String) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.transformations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransformationsCollectionViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? TransformationsCollectionViewCell {
            let transformation = viewModel.transformations[indexPath.row]
            cell.setImage(transformation.photo)
            cell.setName(transformation.name)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.row < viewModel.transformations.count else {
            return
        }
        let transformationFound = viewModel.transformations[indexPath.row]
        print("Transformation found: \(transformationFound.name)")
        self.navigationController?.show(TransformationDetailBuilder(transformationFound).build(), sender: nil)
    }

}


extension CharacterDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CharacterAnnotation else {
            return nil
        }
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CharacterAnnotationView.identifier)  {
            return annotationView
        }
        let annotationView = CharacterAnnotationView(annotation: annotation,
                                                     reuseIdentifier: CharacterAnnotationView.identifier)
        
        return annotationView
    }
    
}
