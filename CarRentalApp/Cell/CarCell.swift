

import UIKit

class CarCell: UICollectionViewCell {
    
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var BrandType: UILabel!
    @IBOutlet weak var carEngine: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    
//    collectionView.register(UINib(nibName: "CollectionCell", bundle: .main), forCellWithReuseIdentifier: "collectionCell")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
