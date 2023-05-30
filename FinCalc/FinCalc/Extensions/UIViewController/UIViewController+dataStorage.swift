import UIKit

protocol DataStorageProtocol {
    func saveOrRemoveValue<T: Equatable>(_ view: T, forKey: String, _ isSavingOn: Bool)
    func retrieveValue<T: Equatable>(_ view: T, forKey: String)
    
    func saveButtonState(_ firstButton: UIButton, forFirstKey: String, _ secondButton: UIButton, forSecondKey: String, _ isSavingOn: Bool)
    func retrieveButtonState(_ button: UIButton, forKey: String) -> Bool
}

extension UIViewController: DataStorageProtocol {
    func saveOrRemoveValue<T: Equatable>(_ view: T, forKey: String, _ isSavingOn: Bool) {
        if isSavingOn {
            let valueToSave: String
            
            if let textField = view as? UITextField {
                let textFieldData = textField.text ?? ""
                valueToSave = textFieldData.isEmpty ? "N/A" : textFieldData
            } else if let label = view as? UILabel {
                valueToSave = label.text ?? ""
            } else {
                return
            }
            
            UserDefaults.standard.setValue(valueToSave, forKey: forKey)
        } else {
            UserDefaults.standard.removeObject(forKey: forKey)
        }
    }

    func retrieveValue<T: Equatable>(_ view: T, forKey: String) {
        if let storedValue = UserDefaults.standard.string(forKey: forKey), storedValue != "N/A" {
            if let textField = view as? UITextField {
                textField.text = storedValue
            } else if let label = view as? UILabel {
                label.text = storedValue
            }
        } else {
            if let textField = view as? UITextField {
                textField.text = ""
            } else if let label = view as? UILabel {
                label.text = "Здесь появятся результаты после того, как вы заполните все поля"
            }
        }
    }
    
    func saveButtonState(_ firstButton: UIButton,  forFirstKey: String, _ secondButton: UIButton, forSecondKey: String, _ isSavingOn: Bool) {
        if isSavingOn {
            let firstValueToSave = firstButton.isSelected
            let secondValueToSave = secondButton.isSelected
            
            UserDefaults.standard.set(firstValueToSave, forKey: forFirstKey)
            UserDefaults.standard.set(secondValueToSave, forKey: forSecondKey)
        } else {
            UserDefaults.standard.removeObject(forKey: forFirstKey)
            UserDefaults.standard.removeObject(forKey: forSecondKey)
        }
    }

    func retrieveButtonState(_ button: UIButton, forKey: String) -> Bool {
        let storedValue = UserDefaults.standard.bool(forKey: forKey)
        button.isSelected = storedValue
        
        return storedValue
    }
}
