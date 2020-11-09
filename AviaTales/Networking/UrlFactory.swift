import Foundation

enum UrlFactory {

    static func buildUrl(with parameter: String) -> URL? {
        var urlComponents = URLComponents(string: "http://places.aviasales.ru/places?")!
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: parameter),
            URLQueryItem(name: "locale", value: "ru")
        ]

        return urlComponents.url
    }
}
