import MapKit

final class MapViewModel {

    private let destination: AirportModel
    private lazy var planeAnnotationPosition = 0
    private lazy var planeDirection = CLLocationDirection()

    var navigationTitle: String {
        "\(AirportModel.saintPetersburgLED.iata)・・・✈︎・・・\(destination.iata)"
    }

    var planeAnnotation = MKPointAnnotation()

    var airportAnnotations: [AirportAnnotation] {
        [
            AirportAnnotation(title: AirportModel.saintPetersburgLED.iata,
                              subtitle: AirportModel.saintPetersburgLED.description,
                              coordinate: AirportModel.saintPetersburgLED.location.clCoordinate),
            AirportAnnotation(title: destination.iata,
                              subtitle: destination.description,
                              coordinate: destination.location.clCoordinate)
        ]
    }

    var flightPathLine: MKGeodesicPolyline {
        let coordinates = [
            AirportModel.saintPetersburgLED.location.clCoordinate,
            destination.location.clCoordinate
        ]
        return .init(coordinates: coordinates, count: coordinates.count)
    }

    var planeRotation: CGFloat {
        CGFloat(degreesToRadians(planeDirection))
    }

    // MARK: - Initializer

    init(destination: AirportModel) {
        self.destination = destination
    }

    func updatePlanePositionAndDirection() -> Bool {
        let planeAnimationStep = 10
        guard planeAnnotationPosition + planeAnimationStep < flightPathLine.pointCount else {
            return false
        }

        let points = flightPathLine.points()
        let previousPoint = points[planeAnnotationPosition]
        planeAnnotationPosition += planeAnimationStep
        let nextPoint = points[planeAnnotationPosition]

        planeDirection = directionBetweenPoints(previousPoint, nextPoint)
        planeAnnotation.coordinate = nextPoint.coordinate
        return true
    }
}

private extension MapViewModel {

    func directionBetweenPoints(_ sourcePoint: MKMapPoint, _ destinationPoint: MKMapPoint) -> CLLocationDirection {
        let x = destinationPoint.x - sourcePoint.x
        let y = destinationPoint.y - sourcePoint.y

        return radiansToDegrees(atan2(y, x)).truncatingRemainder(dividingBy: 360)
    }

    func radiansToDegrees(_ radians: Double) -> Double {
        return radians * 180 / .pi
    }

    func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180
    }
}
