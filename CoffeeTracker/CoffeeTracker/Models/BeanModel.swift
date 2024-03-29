import Foundation
import CoreData
import UIKit

struct BeanModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var style: String
    var buyAgain: Bool
    var roaster: String
    var roastedOn: Date
    var boughtOn: Date
    var notes: String
    var beanType: String
    var objectID: NSManagedObjectID?
    var image: UIImage

    mutating func updateNotes(_ note: String) {
        notes = note
    }

    mutating func addBeansToData(context: NSManagedObjectContext) {
        print(beanType)
        let newBean = Bean(context: context)
        newBean.id = id
        newBean.name = name
        newBean.style = style
        newBean.buyAgain = buyAgain
        newBean.roaster = roaster
        newBean.roastedOn = roastedOn
        newBean.boughtOn = boughtOn
        newBean.notes = notes
        newBean.beanType = beanType
        newBean.beanPhoto = image.jpegData(compressionQuality: 1)

        self.objectID = newBean.objectID

        do {
            try context.save()
            print("Bean saved correctly")
        } catch {
            print("Failed: \(error)")
        }
    }

    func updateBean(context: NSManagedObjectContext) {
        print(beanType)

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
                object.beanType = beanType
                object.beanPhoto = image.jpegData(compressionQuality: 1)
                try context.save()
            }
        } catch {
            print("\(error)")
        }
    }

    func deleteBean(context: NSManagedObjectContext) {

        let fetchRequest: NSFetchRequest<Bean>
        fetchRequest = Bean.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)

        do {
            let objects = try context.fetch(fetchRequest)
            print(objects.count)
            for object in objects {
                context.delete(object)
            }
        } catch {
            print("\(error)")
        }

    }
}
