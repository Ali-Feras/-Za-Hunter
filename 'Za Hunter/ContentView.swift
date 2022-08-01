//
//  ContentView.swift
//  'Za Hunter
//
//  Created by Ali on 01/08/2022.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(
        latitude: 42.0558,
        longitude: -87.6743),
    span: MKCoordinateSpan(
        latitudeDelta: 0.5,
        longitudeDelta: 0.5)
    )
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
