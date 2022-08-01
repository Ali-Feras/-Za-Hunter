//
//  ContentView.swift
//  'Za Hunter
//
//  Created by Ali on 30/7/2022.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @State private var places = [Place]()
    @StateObject var locationManager = LocationManager()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.0558,
            longitude: -87.6743),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5)
    )
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode,
                annotationItems: places) { place in
                MapAnnotation(coordinate: place.annotation.coordinate) {
                    NavigationLink(destination: LocationDetailsView(selectedMapItem: place.mapItem)) {
                        Image("Pizza")
                    }
                }
            }
                .onAppear() {
                    performSearch(item: "Pizza")
                }
                .navigationTitle(" 'Za Hunter")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    func performSearch(item: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = item
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let response = response {
                for mapItem in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = mapItem.placemark.coordinate
                    annotation.title = mapItem.name
                    places.append(Place(annotation: annotation, mapItem: mapItem))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Place: Identifiable {
    let id = UUID()
    let annotation: MKPointAnnotation
    let mapItem: MKMapItem
}

