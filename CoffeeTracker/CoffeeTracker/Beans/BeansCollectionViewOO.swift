//
//  BeansCollectionViewOO.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import Foundation
import CoreData

class BeansCollectionViewOO: NSObject, ObservableObject {
    @Published var beans: [BeanModel] = []

    private let fetchedBeanResultsController: NSFetchedResultsController<Bean>

    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context

        let beanRequest: NSFetchRequest<Bean> = Bean.fetchRequest()
        beanRequest.sortDescriptors = [NSSortDescriptor(key: "boughtOn", ascending: false)]
        self.fetchedBeanResultsController = NSFetchedResultsController(fetchRequest: beanRequest,
                                                                       managedObjectContext: context,
                                                                       sectionNameKeyPath: nil,
                                                                       cacheName: nil)
        super.init()

        fetchedBeanResultsController.delegate = self

        do {
            try fetchedBeanResultsController.performFetch()
            beans = (fetchedBeanResultsController.fetchedObjects ?? []).map({ foundBean -> BeanModel in
                return BeanModel(id: foundBean.id ?? UUID(),
                                 name: foundBean.name ?? "",
                                 style: foundBean.style ?? "",
                                 buyAgain: foundBean.buyAgain,
                                 roaster: foundBean.roaster ?? "",
                                 roastedOn: foundBean.roastedOn ?? Date.distantPast,
                                 boughtOn: foundBean.boughtOn ?? Date.now,
                                 notes: foundBean.notes ?? "",
                                 objectID: foundBean.objectID)
            })
        } catch {
            print("Error")
        }
    }
}

extension BeansCollectionViewOO: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        beans = (controller.fetchedObjects as? [Bean] ?? []).map({ foundBean -> BeanModel in
            return BeanModel(id: foundBean.id ?? UUID(),
                             name: foundBean.name ?? "",
                             style: foundBean.style ?? "",
                             buyAgain: foundBean.buyAgain,
                             roaster: foundBean.roaster ?? "",
                             roastedOn: foundBean.roastedOn ?? Date.distantPast,
                             boughtOn: foundBean.boughtOn ?? Date.now,
                             notes: foundBean.notes ?? "",
                             objectID: foundBean.objectID)
        })
    }
}
