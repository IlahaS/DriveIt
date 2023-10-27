

import Foundation
import RealmSwift

class RealmManager{
    
    let realm = try! Realm()
    func getPath(){
        if let url = realm.configuration.fileURL {
            print(url)
        }
    }
}
