import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with media: Item)
}
