import Foundation

enum AviaTalesError: Error {
    case emptyDestination
    case noAirportFound
    case invalidUrl
    case noData

    var title: String {
        switch self {
        case .noAirportFound:
            return .noAirportFoundAlertTitle

        case .emptyDestination, .invalidUrl, .noData:
            return .generalErrorAlertTitle
        }
    }

    var subtitle: String {
        switch self {
        case .emptyDestination:
            return .emptyDestinationAlertSubitle

        case .noAirportFound:
            return .noAirportFoundAlertSubtitle

        case .invalidUrl:
            return .invalidUrlAlertSubitle

        case .noData:
            return .noDataAlertSubitle
        }
    }
}
