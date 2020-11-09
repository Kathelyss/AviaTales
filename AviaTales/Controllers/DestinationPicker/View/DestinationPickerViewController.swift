import UIKit

protocol DestinationPickerModule: Presentable {
    var onShowRoute: ParameterClosure<AirportModel>? { get set }
}

final class DestinationPickerViewController: BaseViewController<DestinationPickerViewModel>, DestinationPickerModule {

    private let descriptionLabel = DescriptionLabel()
    private let textField = BorderedTextField()
    private let actionButton = BorderedButton()

    // MARK: - DestinationPickerModule

    var onShowRoute: ParameterClosure<AirportModel>?

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()

        view.addSubview(descriptionLabel)
        view.addSubview(textField)
        view.addSubview(actionButton)
    }

    override func bindViews() {
        super.bindViews()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        actionButton.addTarget(self, action: #selector(handleAirportRequestResult), for: .touchUpInside)

        viewModel.onGetAirport = { [weak self] airport in
            DispatchQueue.main.async {
                self?.hideKeyboard()
                self?.onShowRoute?(airport)
            }
        }

        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.hideKeyboard()
                self?.showErrorAlert(error)
            }
        }
    }

    override func configureLayout() {
        super.configureLayout()

        [descriptionLabel, textField, actionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = [
            descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: .largeInset),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -.largeInset),
            descriptionLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -.defaultInset),

            textField.heightAnchor.constraint(equalToConstant: .defaultElementHeight),
            textField.centerYAnchor.constraint(equalTo: safeArea.topAnchor, constant: 150),
            textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: .largeInset),
            textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -.largeInset),

            actionButton.heightAnchor.constraint(equalToConstant: .defaultElementHeight),
            actionButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: .defaultInset),
            actionButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: .largeInset),
            actionButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -.largeInset)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    override func localize() {
        super.localize()

        navigationItem.title = viewModel.navigationTitle
        descriptionLabel.text = viewModel.description
        textField.placeholder = viewModel.textFieldPlaceholder
        actionButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
}

// MARK: - Private methods

private extension DestinationPickerViewController {

    @objc func hideKeyboard() {
        textField.endEditing(true)
    }
    
    @objc func handleAirportRequestResult() {
        guard let destinationName = textField.text, !destinationName.isEmpty else {
            showErrorAlert(AviaTalesError.emptyDestination)
            return
        }

        viewModel.requestAirport(destinationName)
    }

    func showErrorAlert(_ error: Error) {
        let alert: UIAlertController
        switch error {
        case let error as AviaTalesError:
            alert = UIAlertController(title: error.title, message: error.subtitle, preferredStyle: .alert)

        default:
            alert = UIAlertController(title: .generalErrorAlertTitle, message: error.localizedDescription, preferredStyle: .alert)
        }

        alert.addAction(.init(title: .okButtonTitle, style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
