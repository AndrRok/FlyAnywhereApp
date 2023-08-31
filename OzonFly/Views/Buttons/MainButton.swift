import UIKit

class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(backgroundcolor: UIColor, title: String){
        self.init(frame: .zero)
        self.backgroundColor    = backgroundcolor
        self.setTitle(title, for: .normal)
        
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        UIView.setAnimationsEnabled(false)
        self.layoutIfNeeded()
        super.setImage(image, for: .normal)
        UIView.setAnimationsEnabled(true)
    }
    
    private func configure(){
        layer.borderColor       = UIColor.systemGray3.cgColor
        layer.borderWidth       = 2
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String){
        self.backgroundColor    = backgroundColor
        setTitle(title, for: .normal)
    }
}
