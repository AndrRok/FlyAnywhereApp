import UIKit

extension UIView{
    func addSubviews(_ views: UIView...){ for view in views {addSubview(view)} }
    
    func convertDateFromWBStringToCorrectSrtring(inputString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z zzz"
        
        if dateFormatter.date(from: inputString) != nil {
            let date = Date(timeIntervalSinceReferenceDate: 0)
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "HH:mm E, d MMM y"
            let dateString = formatter3.string(from: date)
            
            return dateString
            
        } else {
            return "Невозможно сконвертировать строку в дату"
        }
    }
    
}
