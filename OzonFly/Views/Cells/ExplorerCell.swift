import UIKit

class ExplorerCell: UICollectionViewCell {
    
    static let reuseID = "explorerCell"
    private let hStack = UIStackView()
    private let startStack = UIStackView()
    private let endStack = UIStackView()
    private let priceLabel = MainLabel()
    private let startLocationCode = MainLabel()
    private let  startDate = MainLabel()
    private let endLocationCode = MainLabel()
    private let endDate = MainLabel()
    private let addToFavoritesButton  = MainButton()
    private var flightModel: Flights!

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setCornersRadius()
        configureAddToFavoritesButton()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setFlight(flightModel: Flights){
        self.flightModel = flightModel
        startLocationCode.text = "Аэропорт \nотправления: \n\(flightModel.startLocationCode)"
        startDate.text = "Время \nотправления: \n\(convertDateFromWBStringToCorrectSrtring(inputString: flightModel.startDate))"
        endLocationCode.text = "Аэропорт \nприбытия: \n\(flightModel.endLocationCode)"
        endDate.text = "Время \nприбытия: \n\(convertDateFromWBStringToCorrectSrtring(inputString: flightModel.endDate))"
        priceLabel.text = String("Цена: \n\(flightModel.price)₽")
        
        guard PersistenceManager.sharedRealm.favoriteObjectExist(primaryKey: String(flightModel.searchToken)) else {
            addToFavoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            return
        }
        addToFavoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    private func configureAddToFavoritesButton(){
        contentView.addSubview(addToFavoritesButton)
        addToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        addToFavoritesButton.backgroundColor = .white
        addToFavoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        addToFavoritesButton.tintColor = .cyan
        addToFavoritesButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        addToFavoritesButton.layer.borderWidth = 0
        
        self.addToFavoritesButton.layer.masksToBounds = false
        addToFavoritesButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        addToFavoritesButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        addToFavoritesButton.layer.shadowOpacity = 1.0
        addToFavoritesButton.layer.shadowRadius = 5.0
        
        NSLayoutConstraint.activate([
            addToFavoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            addToFavoritesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            addToFavoritesButton.widthAnchor.constraint(equalToConstant: 40),
            addToFavoritesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func configureLabels(){
        contentView.addSubviews(hStack, priceLabel)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        startStack.translatesAutoresizingMaskIntoConstraints = false
        endStack.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        startLocationCode.translatesAutoresizingMaskIntoConstraints = false
        startDate.translatesAutoresizingMaskIntoConstraints = false
        endLocationCode.translatesAutoresizingMaskIntoConstraints = false
        endDate.translatesAutoresizingMaskIntoConstraints = false
        
        startLocationCode.numberOfLines = 0
        startDate.numberOfLines = 0
        endLocationCode.numberOfLines = 0
        endDate.numberOfLines = 0
        priceLabel.numberOfLines = 0
        
        startStack.addArrangedSubview(startLocationCode)
        startStack.addArrangedSubview(startDate)
        startStack.axis = .vertical
        startStack.layer.borderColor = UIColor.black.cgColor
        startStack.layer.borderWidth = 1
        startStack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        startStack.isLayoutMarginsRelativeArrangement = true
        
        endStack.addArrangedSubview(endLocationCode)
        endStack.addArrangedSubview(endDate)
        endStack.axis = .vertical
        endStack.layer.borderColor = UIColor.black.cgColor
        endStack.layer.borderWidth = 1
        endStack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        endStack.isLayoutMarginsRelativeArrangement = true
        
        hStack.addArrangedSubview(startStack)
        hStack.addArrangedSubview(endStack)
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        hStack.spacing = 3
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: addToFavoritesButton.bottomAnchor, constant: 5),
            hStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hStack.widthAnchor.constraint(equalToConstant: contentView.frame.size.width),
            
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func setCornersRadius(){
        DispatchQueue.main.async {
            self.contentView.layer.cornerRadius = 20
            self.addToFavoritesButton.layer.cornerRadius = 20
        }
    }
    
    @objc private func addToFavorites(){
        guard PersistenceManager.sharedRealm.favoriteObjectExist(primaryKey: String(flightModel.searchToken)) else {
            PersistenceManager.sharedRealm.addFavorite(item: flightModel)
            addToFavoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            return
        }
        PersistenceManager.sharedRealm.deleteDataFromFavorites(idForDelete: String(flightModel.searchToken))
        addToFavoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
