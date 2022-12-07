import UIKit

class HomeViewController: UIViewController {
    
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
                case .header: return LayoutSectionFactory.header()
                case .searchbar: return LayoutSectionFactory.searchbar()
                case .deals: return LayoutSectionFactory.deals()
                case .categories: return LayoutSectionFactory.categories()
                case .featured: return LayoutSectionFactory.featured()
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
            .nib(HeaderCell.self),
            .nib(SearchBarCell.self),
            .nib(DealsCell.self),
            .nib(CategoriesCell.self),
            .nib(FeaturedCell.self),
        ]
        
        collectionView.delegate = self
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
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath)
                return cell
            case .searchbar:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBarCell", for: indexPath)
                return cell
            case .deals:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealsCell", for: indexPath)
                return cell
            case .categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath)
                return cell
            case .featured:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath)
                return cell
                
            default: return nil
                
            }
            
        }
        
        let sections = [
            Section(type: .header, items: [
                Item()
            ]),
            
            Section(type: .searchbar, items: [
                Item()
            ]),
            
            Section(type: .deals, items: [
                Item(), Item(), Item()
            ]),
            
            Section(type: .categories, items: [
                Item(), Item(), Item(), Item()
            ]),
            
            Section(type: .featured, items: [
                Item(), Item(), Item(), Item()
            ])
            
        ]
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
}

extension UIViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
