import CoreLocation

struct Location: Codable {
    let lat: Double
    let lon: Double
}

extension Location {

    var clCoordinate: CLLocationCoordinate2D {
        .init(latitude: lat, longitude: lon)
    }
}
