import Foundation

extension Array {
    public subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
