import Foundation

extension String {

    // MARK: - Constants

    /// ""
    static let empty = ""

    /// " "
    static let whiteSpace = " "

    /// ,
    static let colon = ","

    // MARK: - Destination Picker Module

    /// Тестовое задание от Aviasales
    static let mainNavigationTitle: String = "Тестовое задание от Aviasales"

    /// Введите название страны, города или аэропорта, куда полетит наш самолётик. Начальная точка путешествия - Россия, Санкт-Петербург, аэропорт Пулково
    static let appDescription: String = "Введите название страны, города или аэропорта, куда полетит наш самолётик.\nНачальная точка путешествия - Россия, Санкт-Петербург, аэропорт Пулково"

    /// Куда отправимся?
    static let textFieldPlaceholder: String = "Куда отправимся?"

    /// Полетели
    static let actionButtonTitle: String = "Полетели"

    // MARK: - Errors

    /// Пункт назначения не может быть пустым
    static let emptyDestinationAlertSubitle: String = "Пункт назначения не может быть пустым"

    /// Не удалось получить данные
    static let noDataAlertSubitle: String = "Не удалось получить данные"

    /// Не удалось сформировать URL
    static let invalidUrlAlertSubitle: String = "Не удалось сформировать URL"

    /// Аэропорт не найден
    static let noAirportFoundAlertTitle: String = "Аэропорт не найден"

    /// Кажется, в данной местности нет аэропорта 😕 Попробуйте ввести другое название
    static let noAirportFoundAlertSubtitle: String = "Кажется, в данной местности нет аэропорта 😕\nПопробуйте ввести другое название"

    /// Ошибка
    static let generalErrorAlertTitle: String = "Ошибка"

    /// Ок
    static let okButtonTitle: String = "Ок"

    // MARK: - Saint-Petersburg strings

    /// Санкт-Петербург, Россия
    static let saintPetersburg: String = "Санкт-Петербург, Россия"

    /// LED
    static let saintPetersburgIata: String = "LED"

    /// Пулково
    static let pulkovoAirport: String = "Пулково"

    /// Plane
    static let planeReuseIdentifier: String = "Plane"
}
