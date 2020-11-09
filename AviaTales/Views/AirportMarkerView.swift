import MapKit

final class AirportMarkerView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        canShowCallout = true
        configureAppearance()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureAppearance() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemTeal.cgColor
        layer.cornerRadius = frame.height / 2
        backgroundColor = UIColor.white.withAlphaComponent(0.7)

        let label = UILabel()
        label.textColor = .systemTeal
        label.textAlignment = .center
        label.text = annotation?.title ?? .empty

        addSubview(label)

        label.frame = bounds
    }
}
