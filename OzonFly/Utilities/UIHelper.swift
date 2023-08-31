import UIKit

enum UIHelper{
    //MARK: - Compositional layout for ExplorerVC
    static func createMainLayout(in view: UIView) -> UICollectionViewCompositionalLayout{
        return UICollectionViewCompositionalLayout{_,_ in
            // Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 5, trailing: 4)
            // Group
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), repeatingSubitem: item, count: 1)
            // Sections
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }
}
