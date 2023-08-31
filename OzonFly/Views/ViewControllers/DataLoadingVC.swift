import UIKit

class DataLoadingVC: UIViewController {
    
    var activityIndicatorContainerView = UIView(frame: .zero)
    
    func showLoadingView() {
        activityIndicatorContainerView = UIView(frame: view.bounds)
        view.addSubview(activityIndicatorContainerView)
        
        activityIndicatorContainerView.backgroundColor   = .systemBackground
        activityIndicatorContainerView.alpha             = 0.5
        
        UIView.animate(withDuration: 0.25) { self.activityIndicatorContainerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicatorContainerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){ [self] in
            activityIndicatorContainerView.removeFromSuperview()
        }
    }
}
