import UIKit

extension VATCalculationsVC: VATCalculationsViewModelDelegate {
    func updateResult(_ result: String) {
        updateResultLabel(resultLabel, with: result, in: scrollView)
    }
}
