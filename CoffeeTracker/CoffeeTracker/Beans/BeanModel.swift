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

    mutating func addBeansToData(context: NSManagedObjectContext) {
        let newBean = Bean(context: context)
        newBean.id = id
        newBean.name = name
        newBean.style = style
        newBean.buyAgain = buyAgain
        newBean.roaster = roaster
        newBean.roastedOn = roastedOn
        newBean.boughtOn = boughtOn
        newBean.notes = notes

        self.objectID = newBean.objectID

        do {
            try context.save()
            print("Bean saved correctly")
        } catch {
            print("Failed: \(error)")
        }
    }

    func updateBean(context: NSManagedObjectContext) {
        
        let fetchRequest: NSFetchRequest<Bean>
        fetchRequest = Bean.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)

        do {
            let objects = try context.fetch(fetchRequest)
            print(objects.count)
            for object in objects {
                object.name = name
                object.style = style
                object.buyAgain = buyAgain
                object.roaster = roaster
                object.roastedOn = roastedOn
                object.boughtOn = boughtOn
                object.notes = notes
                try context.save()
            }
        } catch {
            print("\(error)")
        }
    }
}
