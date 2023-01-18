import UIKit

class HomeViewController: UIViewController {
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
            case "header": return LayoutSectionFactory.header()
            case "searchbar": return LayoutSectionFactory.searchbar()
            case "deals": return LayoutSectionFactory.deals()
            case "dotslider": return LayoutSectionFactory.dotslider()
            case "categories": return LayoutSectionFactory.categories()
            case "featuredheader": return LayoutSectionFactory.featuredheader()
            case "featured": return LayoutSectionFactory.featured()
            default: return nil
            }
        }
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with media: Item, for indexPath: IndexPath) -> T {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError("Unable to dequeue \(cellType)")
            }
            cell.configure(with: media)
            return cell
        }
    
    func initialize() {
        setUpCollectionView()
        configureDataSource()
        setDefaults()
    }
    
    func setDefaults() {
        self.title = "Home"
    }
    
    private func setUpCollectionView() {
//        collectionView.register(UINib(nibName: "SectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        
        let cells: [RegisterableView] = [
            .nib(HeaderCell.self),
            .nib(SearchBarCell.self),
            .nib(DealsCell.self),
            .nib(DotSliderCell.self),
            .nib(CategoriesCell.self),
            .nib(FeaturedHeaderCell.self),
            .nib(FeaturedCell.self),
        ]
        collectionView.delegate = self
        collectionView.register(cells: cells)
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self] (collectionView, indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            let  snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[indexPath.section].type
            
            switch sectionType {
            case "header":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath)
                return cell
            case "searchbar":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBarCell", for: indexPath)
                return cell
            case "deals":
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealsCell", for: indexPath)
//                return cell
                return self.configure(DealsCell.self, with: item, for: indexPath)
            case "dotslider":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DotSliderCell", for: indexPath)
                return cell
            case "categories":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath)
                return cell
            case "featuredheader":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedHeaderCell", for: indexPath)
                return cell
            case "featured":
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath)
//                return cell
                return self.configure(FeaturedCell.self, with: item, for: indexPath)
            default: return nil
            }
        }
        
//                let sections = [
//                    Section(id: 0, type: "deals", title: "", items: [
//                        Item(id: 0, image: "", title: ""),
//                        Item(id: 1, image: "", title: ""),
//                        Item(id: 2, image: "", title: "") ]),
//                    Section(id: 1, type: "categories", title: "", items: [
//                        Item(id: 0, image: "", title: ""),
//                        Item(id: 1, image: "", title: ""),
//                        Item(id: 2, image: "", title: "") ]),
//                    Section(id: 2, type: "featured", title: "", items: [
//                        Item(id: 0, image: "", title: ""),
//                        Item(id: 1, image: "", title: ""),
//                        Item(id: 2, image: "", title: "") ])
//                ]
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension HomeViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "ProductDetail", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
