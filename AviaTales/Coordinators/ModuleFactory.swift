import Foundation

final class ModuleFactory {

    func createDestinationPickerModule() -> DestinationPickerModule {
        let viewModel = DestinationPickerViewModel()
        return DestinationPickerViewController(viewModel: viewModel)
    }

    func createMapModule(with destination: AirportModel) -> MapModule {
        let viewModel = MapViewModel(destination: destination)
        return MapViewController(viewModel: viewModel)
    }
}
