import UIKit

final class DescriptionLabel: UILabel {

    init() {
        super.init(frame: .zero)

        configureAppearance()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureAppearance() {
        numberOfLines = 0
        textAlignment = .center
        font = .systemFont(ofSize: 14)
    }
}
