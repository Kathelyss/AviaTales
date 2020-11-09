import UIKit
import MapKit

protocol MapModule: Presentable {}

final class MapViewController: BaseViewController<MapViewModel>, MapModule {

    private let mapView = MKMapView()
    private var planeView: MKAnnotationView?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        configureMap()
    }

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()

        view.addSubview(mapView)
    }

    override func configureLayout() {
        super.configureLayout()

        mapView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    override func localize() {
        super.localize()

        navigationItem.title = viewModel.navigationTitle
    }

    // MARK: - Private methods

    private func configureMap() {
        mapView.register(AirportMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        mapView.showAnnotations(viewModel.airportAnnotations, animated: false)
        mapView.addOverlay(viewModel.flightPathLine)
        mapView.addAnnotation(viewModel.planeAnnotation)

        beginFlightAnimation()
    }

    private func beginFlightAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true) { [weak self] timer in
            if self?.viewModel.updatePlanePositionAndDirection() == false {
                timer.invalidate()
            }
            self?.rotatePlane()
        }
    }

    private func rotatePlane() {
        planeView?.transform = mapView.transform.rotated(by: viewModel.planeRotation)
    }

    deinit {
        mapView.delegate = nil
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case is AirportAnnotation:
            var airportMarkerView = mapView.dequeueReusableAnnotationView(withIdentifier:
                                                                            MKMapViewDefaultAnnotationViewReuseIdentifier)
            airportMarkerView = AirportMarkerView.init(annotation: annotation,
                                                       reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            return airportMarkerView

        default:
            let planeView = mapView.dequeueReusableAnnotationView(withIdentifier: .planeReuseIdentifier)
                ?? MKAnnotationView(annotation: annotation, reuseIdentifier: .planeReuseIdentifier)
            planeView.image = .plane
            self.planeView = planeView
            return planeView
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKGeodesicPolyline else {
            return MKOverlayRenderer()
        }

        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 3
        renderer.strokeColor = .systemTeal
        renderer.lineDashPattern = [0, 6]

        return renderer
    }
}
