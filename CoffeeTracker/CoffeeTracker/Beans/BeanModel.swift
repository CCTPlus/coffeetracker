import Foundation

struct BeanModel: Identifiable {
    let id: UUID = UUID()
    var name: String
    var style: String
    var buyAgain: Bool
    var roaster: String
    var roastedOn: Date
    var boughtOn: Date
    var notes: String
}
