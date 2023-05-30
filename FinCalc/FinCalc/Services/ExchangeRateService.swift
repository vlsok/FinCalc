import UIKit

class ExchangeRateService {
    func fetchExchangeRates(completion: @escaping ([ConverterModel]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.nbrb.by/exrates/rates?periodicity=0") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    let exchangeRates = json?.compactMap { currency -> ConverterModel? in
                        guard let abbreviation = currency["Cur_Abbreviation"] as? String,
                              let rate = currency["Cur_OfficialRate"] as? Double,
                              let scale = currency["Cur_Scale"] as? Int else {
                            return nil
                        }
                        
                        return ConverterModel(abbreviation: abbreviation, rate: rate, scale: scale)
                    }
                    completion(exchangeRates, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
}
