import UIKit

class DealsCell: UICollectionViewCell, SelfConfiguringCell {
    static let kind = String(describing: DealsCell.self)
    static let reuseIdentifier = String(describing: DealsCell.self)
    static let nib = UINib(nibName: String(describing: DealsCell.self), bundle: nil)
    
    @IBOutlet weak var dealImage: UIImageView!
    
    func configure(with media: Item) {
        dealImage.image = UIImage(named: media.image)
    }
}
