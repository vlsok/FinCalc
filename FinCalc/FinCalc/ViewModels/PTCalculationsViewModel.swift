import UIKit

protocol PTCalculationsViewModelDelegate: AnyObject {
    func updateResult(_ result: String)
}

class PTCalculationsViewModel {
    weak var delegate: PTCalculationsViewModelDelegate?
    
    var model: PTCalculationsModel? {
        didSet {
            calculatePT()
        }
    }
    
    func calculatePT() {
        guard let square = model?.square,
              let cost = model?.cost,
              let rate = model?.rate else {
            delegate?.updateResult("Здесь появятся результаты после того, как вы заполните все поля")
            return
        }
        
        var result = ""
        
        let valueFull = square * cost * (rate / 100)
        let valueHalf = (square * cost * (rate / 100)) / 2
        
        result = "За 1 год вы обязаны уплатить \(valueFull.restrictPrecision(2.0)) BYN налога на недвижимость.\n\nЗа 6 месяцев - \(valueHalf.restrictPrecision(2.0)) BYN"
        
        delegate?.updateResult(result)
    }
}
