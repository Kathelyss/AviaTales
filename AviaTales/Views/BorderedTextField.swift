import UIKit

final class BorderedTextField: UITextField {

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
        borderStyle = .roundedRect
        clearButtonMode = .whileEditing
    }
}
