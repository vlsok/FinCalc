import UIKit

extension Double {
    func restrictPrecision(_ power: Double) -> Double {
        let precision = pow(10.0, power)
        let roundedValue = (self * precision).rounded() / precision
        return roundedValue
    }
}
