//
//  MapViewController.swift
//  GoogleMapsSwiftUIOfficialExemple
//
//  Created by Madalin Zaharia on 25.10.2023.
//

import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    
    let map = GMSMapView(frame: .zero)
    var isAnimating: Bool = false
    
    override func loadView() {
        super.loadView()
        self.view = map
    }
}
