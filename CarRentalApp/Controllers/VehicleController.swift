

import UIKit
import RealmSwift

class VehicleController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    
    var items = [CarManager]()
    var helper = RealmManager()
    let realm = try! Realm()
    var searchedItems = [CarManager]()
    var isSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchItems()
        searchField.delegate = self
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(UINib(nibName: "CarCell", bundle: nil), forCellWithReuseIdentifier: "CarCell")
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    
    func fetchItems() {
        items.removeAll()
        let data = realm.objects(CarManager.self)
        items.append(contentsOf: data)
        collection.reloadData()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchField.endEditing(true)
        collection.reloadData()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        if let searchText = searchField.text, !searchText.isEmpty {
            isSearched = true
            searchedItems = items.filter { car in
                if let name = car.name {
                    return name.lowercased().contains(searchText.lowercased())
                }
                return false
            }
            isSearched = true
        } else {
            searchedItems.removeAll()
            isSearched = false
        }
        collection.reloadData()
        
    }
    
}

extension VehicleController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        // print(searchField.text!)
        collection.reloadData()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchField.text != "" {
            collection.reloadData()
            return true
        } else{
            textField.placeholder = "Type something!"
            return false
        }
    }
    
}

extension VehicleController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearched{
            return searchedItems.count
        }else{
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as! CarCell
        if isSearched{
            cell.carName.text = searchedItems[indexPath.row].name
            cell.carImage.image = UIImage(named: searchedItems[indexPath.row].model ?? "")
            cell.carPrice.text = searchedItems[indexPath.row].price
            cell.carEngine.text = searchedItems[indexPath.row].engine
        }else{
            cell.carName.text = items[indexPath.row].name
            cell.carImage.image = UIImage(named: items[indexPath.row].model ?? "")
            cell.carPrice.text = items[indexPath.row].price
            cell.carEngine.text = items[indexPath.row].engine
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: view.frame.width, height: view.frame.width)
//    }
    
    
}
