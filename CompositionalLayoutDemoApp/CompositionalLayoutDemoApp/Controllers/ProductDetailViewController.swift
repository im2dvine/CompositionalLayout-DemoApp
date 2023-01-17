import UIKit

class ProductDetailViewController: UIViewController {
    let sections = Bundle.main.decode([Section].self, from: "data.json")
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, enviroment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[sectionIndex].type
            
            switch sectionType {
            case "imageheader": return LayoutSectionFactory.imageheader()
            case "details": return LayoutSectionFactory.details()
            case "variant": return LayoutSectionFactory.variant()
            case "specifications": return LayoutSectionFactory.specifications()
            case "cart": return LayoutSectionFactory.cart()
            default: return nil
            }
        }
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        setUpCollectionView()
        configureDataSource()
        setDefaults()
    }
    
    func setDefaults() {
        self.title = "Detail"
    }
    
    private func setUpCollectionView() {
        let cells: [RegisterableView] = [
            .nib(ImageHeaderCell.self),
            .nib(DetailsCell.self),
            .nib(VariantCell.self),
            .nib(SpecificationsCell.self),
            .nib(CartCell.self)
        ]
        collectionView.register(cells: cells)
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self] (collectionView, indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            let  snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[indexPath.section].type
            
            switch sectionType {
            case "imageheader":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageHeaderCell", for: indexPath)
                return cell
            case "details":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath)
                return cell
            case "variant":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VariantCell", for: indexPath)
                return cell
            case "specifications":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificationsCell", for: indexPath)
                return cell
            case "cart":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath)
                return cell
            default: return nil
            }
        }
        
//        let sections = [
//            Section(type: "imageheader", items: [ Item() ]),
//            Section(type: "details", items: [ Item() ]),
//            Section(type: "variant", items: [ Item() ]),
//            Section(type: "specifications", items: [ Item() ]),
//            Section(type: "cart", items: [ Item() ])
//        ]
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
