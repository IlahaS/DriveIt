

import UIKit
import RealmSwift

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var category: [String] = ["Standard", "Prestige", "SUV"]
    var items = [CarManager]()
    var helper = RealmManager()
    let realm = try! Realm()
    var categoryCounts = [String: Int]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "carCategoryCell", bundle: .main), forCellWithReuseIdentifier: "carCategoryCell")
        fetchItems()
    }
    
    func fetchItems() {
        items.removeAll()
        let data = realm.objects(CarManager.self)
        items.append(contentsOf: data)
        collectionView.reloadData()
    }
}

extension CollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carCategoryCell", for: indexPath) as! carCategoryCell
        cell.categoryImage.image = UIImage(named: category[indexPath.item])
        let category = CarType.allCases[indexPath.item]
        cell.categoryType.text = category.rawValue
        if let count = categoryCounts[category.rawValue] {
            cell.categoryCount.text = "\(count)"
        } else {
            cell.categoryCount.text = "0"
        }
        return cell
    }
    
    
}
