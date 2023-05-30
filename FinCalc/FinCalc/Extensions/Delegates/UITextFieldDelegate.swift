import UIKit

extension UIViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }

        let decimalSeparators = [".", ","]
        let currentSeparator = Locale.current.decimalSeparator ?? "."

        if !text.contains(where: { $0.isNumber }) && decimalSeparators.contains(string) {
            return false
        }

        if text.components(separatedBy: currentSeparator).count > 1 && decimalSeparators.contains(string) {
            return false
        }

        let maxLength = text.contains(where: { decimalSeparators.contains(String($0)) }) ? 13 : 12

        let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: decimalSeparators.joined()))
        let filteredString = string.filter { allowedCharacters.contains(UnicodeScalar(String($0))!) }

        let newText = (text as NSString).replacingCharacters(in: range, with: filteredString)

        if newText.count > maxLength {
            return false
        }

        if let separatorRange = newText.range(of: currentSeparator) {
            let decimalPart = newText[separatorRange.upperBound...]
            if decimalPart.count > 2 {
                return false
            }
        }

        if let separatorIndex = newText.firstIndex(of: Character(currentSeparator)) {
            let numericPart = newText[..<separatorIndex].replacingOccurrences(of: currentSeparator, with: "")
            if numericPart.count > 10 {
                return false
            }
        } else {
            let numericPart = newText.replacingOccurrences(of: currentSeparator, with: "")
            if numericPart.count > 10 {
                return false
            }
        }

        return true
    }
}

