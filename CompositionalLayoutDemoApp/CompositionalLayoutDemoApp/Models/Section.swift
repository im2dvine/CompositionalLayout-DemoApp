import Foundation

struct Section: Hashable {
    let id = UUID()
    let type: SectionType
    let title: String
    let subtitle: String
    let items: [Item]
    
    init(type: SectionType, title: String = "", subtitle: String = "", items: [Item] = []) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }
    
    enum ItemSectionType: String {
        case header
        case searchbar
        case deals
        case categories
        case featured
        case imageheader
        case details
        case variant
        case specifications
        case cart
    }
    
    struct SectionType: RawRepresentable, Hashable {
        typealias RawValue = String
        var rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        static let header = SectionType(rawValue: Section.ItemSectionType.header.rawValue)
        static let searchbar = SectionType(rawValue: Section.ItemSectionType.searchbar.rawValue)
        static let deals = SectionType(rawValue: Section.ItemSectionType.deals.rawValue)
        static let categories = SectionType(rawValue: Section.ItemSectionType.categories.rawValue)
        static let featured = SectionType(rawValue: Section.ItemSectionType.featured.rawValue)
        static let imageheader = SectionType(rawValue: Section.ItemSectionType.imageheader.rawValue)
        static let details = SectionType(rawValue: Section.ItemSectionType.details.rawValue)
        static let variant = SectionType(rawValue: Section.ItemSectionType.variant.rawValue)
        static let specifications = SectionType(rawValue: Section.ItemSectionType.specifications.rawValue)
        static let cart = SectionType(rawValue: Section.ItemSectionType.cart.rawValue)
    }
}
