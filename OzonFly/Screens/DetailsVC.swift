//
//  DtailsVC.swift
//  OzonFly
//
//  Created by ARMBP on 8/29/23.
//


protocol ReloadViewProtocol {
    func reloadView()
}

import UIKit

class DetailsVC: UIViewController {
    
    var reloadDelegate: ReloadViewProtocol?
    private let hStack = UIStackView()
    private let startStack = UIStackView()
    private let endStack = UIStackView()
    private let priceLabel = MainLabel()
    private let startLocationCode = MainLabel()
    private let  startDate = MainLabel()
    private let endLocationCode = MainLabel()
    private let endDate = MainLabel()
    private let addToFavoritesButton  = MainButton()
    private var flightModel: Flights
    
    init(flightModel: Flights) {
        self.flightModel = flightModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setCornersRadius()
        configureAddToFavoritesButton()
        configureLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reloadDelegate?.reloadView()
    }
    
    private func configureAddToFavoritesButton(){
        view.addSubview(addToFavoritesButton)
        addToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        addToFavoritesButton.backgroundColor = .white
        addToFavoritesButton.tintColor = .cyan
        addToFavoritesButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        addToFavoritesButton.layer.borderWidth = 0//remove later
        
        self.addToFavoritesButton.layer.masksToBounds = false
        addToFavoritesButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        addToFavoritesButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        addToFavoritesButton.layer.shadowOpacity = 1.0
        addToFavoritesButton.layer.shadowRadius = 5.0
        
        DispatchQueue.main.async { [self] in
            guard PersistenceManager.sharedRealm.favoriteObjectExist(primaryKey: String(flightModel.searchToken)) else {
                addToFavoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
                return
            }
            addToFavoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        NSLayoutConstraint.activate([
            addToFavoritesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addToFavoritesButton.widthAnchor.constraint(equalToConstant: 40),
            addToFavoritesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func configureLabels(){
        view.addSubviews(hStack, priceLabel)
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

        startLocationCode.text = "Аэропорт \nотправления: \n\(flightModel.startLocationCode)"
        startDate.text = "Время \nотправления: \n\(convertDateFromWBStringToCorrectSrtring(inputString: flightModel.startDate))"
        endLocationCode.text = "Аэропорт \nприбытия: \n\(flightModel.endLocationCode)"
        endDate.text = "Время \nприбытия: \n\(convertDateFromWBStringToCorrectSrtring(inputString: flightModel.endDate))"
        priceLabel.text = String("Цена \n\(flightModel.price)₽")
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: addToFavoritesButton.bottomAnchor, constant: 50),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            
            priceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setCornersRadius(){
        DispatchQueue.main.async {
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
