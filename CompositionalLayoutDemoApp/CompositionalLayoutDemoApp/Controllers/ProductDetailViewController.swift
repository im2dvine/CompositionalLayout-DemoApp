import UIKit

class ProductDetailViewController: UIViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, enviroment) ->
            NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[sectionIndex].type
            
            switch sectionType {
            case .imageheader: return LayoutSectionFactory.imageheader()
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
    }

    private func setUpCollectionView() {
        let cells: [RegisterableView] = [
            .nib(ImageHeaderCell.self)
        ]
        
        collectionView.register(cells: cells)
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self]
            (collectionView, indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            
            let  snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[indexPath.section].type
            
            switch sectionType {
            case .imageheader:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageHeaderCell", for: indexPath)
                return cell
                
            default: return nil
                
            }
            
        }
        
        let sections = [
            Section(type: .imageheader, items: [
                Item()
            ])
        
        ]
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }

}
