import Foundation

struct Section: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let items: [Item]
}
