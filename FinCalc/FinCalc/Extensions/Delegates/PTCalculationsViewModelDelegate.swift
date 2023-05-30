import UIKit

extension PTCalculationsVC: PTCalculationsViewModelDelegate {
    func updateResult(_ result: String) {
        updateResultLabel(resultLabel, with: result, in: scrollView)
    }
}
