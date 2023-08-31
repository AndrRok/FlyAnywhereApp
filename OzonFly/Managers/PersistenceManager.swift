
import Foundation
import RealmSwift

class FavoriteItemsRealm: Object{
    @Persisted dynamic var idOfItem     = String()//primary key (not for sorting)
    override static func primaryKey() -> String? { return "idOfItem" }
    @Persisted(primaryKey: true) var id: ObjectId//for sorting
}

class PersistenceManager{
    static let sharedRealm = PersistenceManager()
    private let realm = try! Realm()
    
    var favoriteItem: Results<FavoriteItemsRealm> {return realm.objects(FavoriteItemsRealm.self).sorted(byKeyPath: "id", ascending: false)}//sorting
    
    func favoriteObjectExist(primaryKey: String) -> Bool {//check if object already exists
        return realm.object(ofType: FavoriteItemsRealm.self, forPrimaryKey: primaryKey) != nil
    }
    
    func addFavorite(item: Flights ){
        let favoriteItem = FavoriteItemsRealm()
        favoriteItem.idOfItem  = String(item.searchToken)
        try! realm.write{ realm.add(favoriteItem) }
    }
    
    func deleteDataFromFavorites(idForDelete: String){
        let realm = try! Realm()
        let data = realm.object(ofType: FavoriteItemsRealm.self, forPrimaryKey: idForDelete)
        if data != nil{
            try! realm.write {
                realm.delete(data!)
            }
        }
    }
}

