import Foundation
import CoreData

struct BeanModel: Identifiable, Hashable {
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

    func addBeansToData(context: NSManagedObjectContext) {
        let newBean = Bean(context: context)
        newBean.id = id
        newBean.name = name
        newBean.style = style
        newBean.buyAgain = buyAgain
        newBean.roaster = roaster
        newBean.roastedOn = roastedOn
        newBean.boughtOn = boughtOn
        newBean.notes = notes

        do {
            try context.save()
            print("Bean saved correctly")
        } catch {
            print("Failed: \(error)")
        }
    }
}
