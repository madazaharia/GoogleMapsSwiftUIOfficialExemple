//
//  ContentView.swift
//  GoogleMapsSwiftUIOfficialExemple
//
//  Created by Madalin Zaharia on 25.10.2023.
//

import GoogleMaps
import SwiftUI

/// The root view of the application displaying a map that the user can interact with and a
/// button where the user
struct ContentView: View {
    
    static let cities = [
        City(name: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.7576, longitude: -122.4194)),
        City(name: "Seattle", coordinate: CLLocationCoordinate2D(latitude: 47.6131742, longitude: -122.4824903)),
        City(name: "Singapore", coordinate: CLLocationCoordinate2D(latitude: 1.3440852, longitude: 103.6836164)),
        City(name: "Sydney", coordinate: CLLocationCoordinate2D(latitude: -33.8473552, longitude: 150.6511076)),
        City(name: "Tokyo", coordinate: CLLocationCoordinate2D(latitude: 35.6684411, longitude: 139.6004407))
    ]
    
    /// State for markers displayed on the map for each city in `cities`
    @State var markers: [GMSMarker] = cities.map {
        let marker = GMSMarker(position: $0.coordinate)
        marker.title = $0.name
        return marker
    }
    
    @State var zoomInCenter: Bool = false
    @State var expandList: Bool = false
    @State var selectedMarker: GMSMarker?
    @State var yDragTranslation: CGFloat = 0
    
    // MARK: - Drawing
    var body: some View {
        
        let scrollViewHeight: CGFloat = 80
        
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Map
                let diameter = zoomInCenter ? geometry.size.width : (geometry.size.height * 2)
                MapViewControllerBridge(
                    markers: $markers,
                    selectedMarker: $selectedMarker,
                    onAnimationEnded: {
                        self.zoomInCenter = true
                    },
                    mapViewWillMove: { isGesture in
                        guard isGesture else { return }
                        self.zoomInCenter = false
                    }
                )
                .clipShape(
                    Circle()
                        .size(
                            width: diameter,
                            height: diameter
                        )
                        .offset(
                            CGPoint(
                                x: (geometry.size.width - diameter) / 2,
                                y: (geometry.size.height - diameter) / 2
                            )
                        )
                )
                .animation(.easeIn)
                .background(Color(red: 254.0/255.0, green: 1, blue: 220.0/255.0))
                
                // Cities List
                CitiesList(markers: $markers) { marker in
                    guard self.selectedMarker != marker else { return }
                    self.selectedMarker = marker
                    self.zoomInCenter = false
                    self.expandList = false
                }  handleAction: {
                    self.expandList.toggle()
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(
                    x: 0,
                    y: geometry.size.height - (expandList ? scrollViewHeight + 150 : scrollViewHeight)
                )
                .offset(x: 0, y: self.yDragTranslation)
                .animation(.spring())
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.yDragTranslation = value.translation.height
                        }
                        .onEnded { value in
                            self.expandList = (value.translation.height < -120)
                            self.yDragTranslation = 0
                        }
                )
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
