import Foundation

struct BeanModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var style: String
    var buyAgain: Bool
    var roaster: String
    var roastedOn: Date
    var boughtOn: Date
    var notes: String

    mutating func updateNotes(_ note: String) {
        notes = note
    }
}
