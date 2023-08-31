import UIKit

extension UIViewController {
    
    func presentCustomAllertOnMainThred(allertTitle: String, message: String, butonTitle: String){
        DispatchQueue.main.async {
            let allertVC = AlertVC(allertTitle: allertTitle, message: message, buttonTitle: butonTitle)
            allertVC.modalPresentationStyle = .overFullScreen
            allertVC.modalTransitionStyle = .crossDissolve
            self.present(allertVC, animated: true)
        }
    }
    
    func convertDateFromWBStringToCorrectSrtring(inputString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z zzz"
        if dateFormatter.date(from: inputString) != nil {
            let date = Date(timeIntervalSinceReferenceDate: 0)
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm E, d MMM y"
            let dateString = formatter.string(from: date)
            return dateString
        } else {
            return "Невозможно сконвертировать строку в дату"
        }
    }
    
    
}

