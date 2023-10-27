
import UIKit
import RealmSwift

class SearchController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchText: UITextField!
    
    let helper = RealmManager()
    var items = [CarManager]()
    let realm = try! Realm()
    var searchedItems = [CarManager]()
    var isSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        helper.getPath()
        fetchItems()
        searchText.delegate = self
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "CarCell", bundle: nil), forCellWithReuseIdentifier: "CarCell")
        
    }
    
    func fetchItems() {
        items.removeAll()
        let data = realm.objects(CarManager.self)
        items.append(contentsOf: data)
        collection.reloadData()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchText.endEditing(true)
        collection.reloadData()
    }
    
}

extension SearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        // print(searchField.text!)
        collection.reloadData()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let text = searchText.text, !text.isEmpty {
            searchedItems = items.filter { car in
                if let name = car.name {
                    return name.lowercased().contains(text.lowercased())
                }
                return false
            }
            isSearched = true
        } else {
            searchedItems.removeAll()
            isSearched = false
        }
        collection.reloadData()
        searchText.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchText.text != "" {
            collection.reloadData()
            return true
        } else{
            textField.placeholder = "Type something!"
            return false
        }
    }
    
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource{
    
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

}


