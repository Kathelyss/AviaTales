import UIKit

final class DestinationPickerViewModel {

    private let networkService = NetworkService()

    let navigationTitle: String = .mainNavigationTitle
    let description: String = .appDescription
    let textFieldPlaceholder: String = .textFieldPlaceholder
    let buttonTitle: String = .actionButtonTitle

    var onGetAirport: ParameterClosure<AirportModel>?
    var onError: ParameterClosure<Error>?

    func requestAirport(_ destinationName: String) {
        networkService.requestAirportByDestination(destinationName) { result in
            switch result {
            case let .success(airport):
                self.onGetAirport?(airport)

            case let .failure(error):
                self.onError?(error)
            }
        }
    }
}
