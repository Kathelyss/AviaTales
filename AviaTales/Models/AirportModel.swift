import Foundation

struct AirportModel: Codable {
    
    let name: String
    let airportName: String?
    let iata: String
    let location: Location
}

extension AirportModel {

    static let saintPetersburgLED = AirportModel(name: .saintPetersburg,
                                                 airportName: .pulkovoAirport,
                                                 iata: .saintPetersburgIata,
                                                 location: Location(lat: 59.806084, lon: 30.3083))

    var description: String {
        [name, airportName ?? .empty].joined(separator: .colon + .whiteSpace)
    }
}
