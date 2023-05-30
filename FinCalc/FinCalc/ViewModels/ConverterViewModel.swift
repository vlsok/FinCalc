import UIKit

class ConverterViewModel {
    private let exchangeRateService: ExchangeRateService
    private var exchangeRates: [ConverterModel] = []
    
    var dollarLabelText: String {
        guard let usdToBynRate = exchangeRates.first(where: { $0.abbreviation == "USD" }) else {
            return ""
        }
        return "1 USD = \(usdToBynRate.rate.restrictPrecision(4.0)) BYN"
    }
    
    var rubleLabelText: String {
        guard let usdToBynRate = exchangeRates.first(where: { $0.abbreviation == "USD" }),
              let rubToBynRate = exchangeRates.first(where: { $0.abbreviation == "RUB" }) else {
            return ""
        }
        
        let usdToRubRate = (usdToBynRate.rate / Double(usdToBynRate.scale)) /
                           (rubToBynRate.rate / Double(rubToBynRate.scale))
        
        return "1 USD = \(usdToRubRate.restrictPrecision(4.0)) RUB"
    }
    
    var euroLabelText: String {
        guard let usdToBynRate = exchangeRates.first(where: { $0.abbreviation == "USD" }),
              let eurToBynRate = exchangeRates.first(where: { $0.abbreviation == "EUR" }) else {
            return ""
        }
        
        let usdToEurRate = (usdToBynRate.rate / Double(usdToBynRate.scale)) / (eurToBynRate.rate / Double(eurToBynRate.scale))
        
        return "1 USD = \(usdToEurRate.restrictPrecision(4.0)) EUR"
    }
    
    var zlotyLabelText: String {
        guard let usdToBynRate = exchangeRates.first(where: { $0.abbreviation == "USD" }),
              let plnToBynRate = exchangeRates.first(where: { $0.abbreviation == "PLN" }) else {
            return ""
        }
        
        let usdToPlnRate = (usdToBynRate.rate / Double(usdToBynRate.scale)) / (plnToBynRate.rate / Double(plnToBynRate.scale))
        
        return "1 USD = \(usdToPlnRate.restrictPrecision(4.0)) PLN"
    }
    
    var hryvniaLabelText: String {
        guard let usdToBynRate = exchangeRates.first(where: { $0.abbreviation == "USD" }),
              let uahToBynRate = exchangeRates.first(where: { $0.abbreviation == "UAH" }) else {
            return ""
        }
        
        let usdToUahRate = (usdToBynRate.rate / Double(usdToBynRate.scale)) / (uahToBynRate.rate / Double(uahToBynRate.scale))
        
        return "1 USD = \(usdToUahRate.restrictPrecision(4.0)) UAH"
    }
    
    init(exchangeRateService: ExchangeRateService) {
        self.exchangeRateService = exchangeRateService
    }
    
    func fetchExchangeRates(completion: @escaping (Error?) -> Void) {
        exchangeRateService.fetchExchangeRates { [weak self] (exchangeRates, error) in
            guard let self = self else { return }
            
            if let exchangeRates = exchangeRates {
                self.exchangeRates = exchangeRates
            }
            
            completion(error)
        }
    }
}

