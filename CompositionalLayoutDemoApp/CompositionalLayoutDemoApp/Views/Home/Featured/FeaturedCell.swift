import UIKit

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
    static let kind = String(describing: FeaturedCell.self)
    static let reuseIdentifier = String(describing: FeaturedCell.self)
    static let nib = UINib(nibName: String(describing: FeaturedCell.self), bundle: nil)
    
    @IBOutlet weak var featuredImage: UIImageView!
    
    @IBOutlet weak var featuredLabel: UILabel!
    
    func configure(with media: Item) {
        featuredImage.image = UIImage(named: media.image)
        featuredLabel.text = media.title
    }
    
}
