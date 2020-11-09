import Foundation

final class NetworkService {

    private let session = URLSession.shared

    func requestAirportByDestination(_ destinationName: String,
                                     completion: @escaping ParameterClosure<Result<AirportModel, Error>>) {
        guard let url = UrlFactory.buildUrl(with: destinationName) else {
            completion(.failure(AviaTalesError.invalidUrl))
            return
        }

        performRequest(by: url) { result in
            switch result {
            case let .success(data):
                do {
                    let airPorts: [AirportModel] = try self.decode(data: data)
                    guard let destination = airPorts.first(where: { $0.airportName != nil }) else {
                        completion(.failure(AviaTalesError.noAirportFound))
                        return
                    }

                    completion(.success(destination))
                } catch {
                    completion(.failure(error))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func performRequest(by url: URL, completion: @escaping ParameterClosure<Result<Data, Error>>) {
        
        let task = session.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data else {
                completion(.failure(AviaTalesError.noData))
                return
            }

            completion(.success(data))
        })

        task.resume()
    }

    private func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(T.self, from: data)
    }
}
