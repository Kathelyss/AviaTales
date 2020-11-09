import UIKit

final class BorderedButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            setTitleColor(isHighlighted ? .white : .systemTeal, for: .normal)
            backgroundColor = isHighlighted ? .systemTeal : .white
        }
    }

    init() {
        super.init(frame: .zero)

        configureAppearance()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureAppearance() {
        backgroundColor = .white
        setTitleColor(.systemTeal, for: .normal)

        clipsToBounds = true
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemTeal.withAlphaComponent(0.5).cgColor
    }
}
