import UIKit

class ConverterVC: UIViewController {
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var rubleLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var zlotyLabel: UILabel!
    @IBOutlet weak var hryvniaLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let refreshControl = UIRefreshControl()
    let styleSheet = StyleSheet()
    
    private var viewModel: ConverterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        styleSheet.updateRefreshControlTintColor(refreshControl)
    }
    
    private func setup() {
        viewModel = ConverterViewModel(exchangeRateService: ExchangeRateService())
        
        setupRefreshControl()
        styleSheet.addTopInsetView(scrollView)
        fetchExchangeRates()
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshExchangeRates), for: .valueChanged)
        
        styleSheet.updateRefreshControlTintColor(refreshControl)
        
        scrollView.refreshControl = refreshControl
    }
    
    private func fetchExchangeRates() {
        viewModel.fetchExchangeRates { [weak self] (error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)")
                }
                
                self.updateExchangeRates()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func updateExchangeRates() {
        dollarLabel.text = viewModel.dollarLabelText
        rubleLabel.text = viewModel.rubleLabelText
        euroLabel.text = viewModel.euroLabelText
        zlotyLabel.text = viewModel.zlotyLabelText
        hryvniaLabel.text = viewModel.hryvniaLabelText
    }
    
    @objc
    func refreshExchangeRates() {
        fetchExchangeRates()
    }
}
