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
    var objectID: NSManagedObjectID?

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

    func updateBean(context: NSManagedObjectContext) {
        guard let objectID = objectID else {
            print("❌ No object ID for update")
            return
        }

        do {
            let object: Bean = try context.existingObject(with: objectID) as! Bean
            object.name = name
            object.style = style
            object.buyAgain = buyAgain
            object.roaster = roaster
            object.roastedOn = roastedOn
            object.boughtOn = boughtOn
            object.notes = notes
            try context.save()
        } catch {
            print("❌ Error")
        }
    }
}
