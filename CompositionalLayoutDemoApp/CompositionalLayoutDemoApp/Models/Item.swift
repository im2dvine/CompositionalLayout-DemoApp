import Foundation

struct Item: Decodable, Hashable {
    let id: Int
    let image: String
    let title: String
}
