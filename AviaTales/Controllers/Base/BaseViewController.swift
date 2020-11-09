import UIKit

class BaseViewController<ViewModel>: UIViewController {

    let viewModel: ViewModel
    lazy var safeArea = view.safeAreaLayoutGuide

    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }

    func initializeView() {
        addSubviews()
        bindViews()
        configureLayout()
        configureAppearance()
        localize()
    }

    func addSubviews() {}

    func bindViews() {}

    func configureAppearance() {
        view.backgroundColor = .white
    }

    func configureLayout() {}

    func localize() {}
}
