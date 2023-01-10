import Foundation

struct Item: Decodable, Hashable {
    let id: Int
    let title: String
    let date: String
    let image: String
}
