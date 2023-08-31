
import UIKit

class ExplorerVC: DataLoadingVC {
    enum Section{case main}
    private var dataSource: UICollectionViewDiffableDataSource<Section, Flights>!
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createMainLayout(in: view))
    private var itemsArray: [Flights] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        getList()
    }
    
    private func configureUI(){
        configureCollectionView()
    }
    
    private func getList(){
        showLoadingView()
        NetworkManager.shared.getMainRequest  { [weak self] result in
            guard let self = self else { return }
            dismissLoadingView()
            switch result {
            case .success(let itemsResult):
                
                self.itemsArray = itemsResult.flights
                self.updateDataSource(on: itemsResult.flights)
            case .failure(let error):
                self.presentCustomAllertOnMainThred(allertTitle: String(localized: "Bad Stuff Happend"), message: error.rawValue, butonTitle: String(localized: "Ok"))
            }
        }
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(ExplorerCell.self, forCellWithReuseIdentifier: ExplorerCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        collectionView.contentInset = insets
        collectionView.backgroundColor = .systemGray3
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Flights>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, item)-> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorerCell.reuseID, for: indexPath) as? ExplorerCell
            cell?.setFlight(flightModel: item)
            cell?.layoutIfNeeded()
            return cell
        })
    }
    
    func updateDataSource(on dataResult: [Flights] ){
        var snapShot = NSDiffableDataSourceSnapshot<Section, Flights>()
        snapShot.appendSections([.main])
        snapShot.appendItems(dataResult)
        DispatchQueue.main.async { self.dataSource.apply(snapShot, animatingDifferences: true) }
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ExplorerVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = itemsArray[indexPath.row]
        let itemDetailsVC =  DetailsVC(flightModel: item)
        itemDetailsVC.reloadDelegate = self
        self.present(itemDetailsVC, animated: true, completion: nil)
    }
}

extension ExplorerVC: ReloadViewProtocol {
    func reloadView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
