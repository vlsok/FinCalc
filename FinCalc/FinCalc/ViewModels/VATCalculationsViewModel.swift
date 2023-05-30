import UIKit

protocol VATCalculationsViewModelDelegate: AnyObject {
    func updateResult(_ result: String)
}

class VATCalculationsViewModel {
    enum Mode {
        case extract
        case charge
        case none
    }
    
    weak var delegate: VATCalculationsViewModelDelegate?
    
    var model: VATCalculationsModel? {
        didSet {
            calculateVAT()
        }
    }

    var mode: Mode = .extract {
        didSet {
            calculateVAT()
        }
    }

    func updateMode(_ newMode: Mode) {
        mode = newMode
    }

    func calculateVAT() {
        guard let sum = model?.sum,
              let rate = model?.rate else {
            delegate?.updateResult("Здесь появятся результаты после того, как вы заполните все поля")
            return
        }
        
        var result = ""
        
        switch mode {
            case .extract:
                let totalWith: Double = sum
                let totalWithout: Double = sum - (sum * rate / (100 + rate))
                let vat: Double = sum * rate / (100 + rate)
                
            result = "Сумма с НДС: \(totalWith.restrictPrecision(2.0)) BYN.\n\nСумма без НДС: \(totalWithout.restrictPrecision(2.0)) BYN.\n\nНДС: \(vat.restrictPrecision(2.0)) BYN."
                
            case .charge:
                let totalWith: Double = sum + (sum * rate) / 100
                let totalWithout: Double = sum
                let vat: Double = sum * rate / 100
                
            result = "Сумма с НДС: \(totalWith.restrictPrecision(2.0)) BYN.\n\nСумма без НДС: \(totalWithout.restrictPrecision(2.0)) BYN.\n\nНДС: \(vat.restrictPrecision(2.0)) BYN."
            
            case .none:
                result = "Здесь появятся результаты после того, как вы заполните все поля"
        }
        
        delegate?.updateResult(result)
    }
    
}
