//
//  ScreenshotSampleData.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 10/29/26.
//

#if DEBUG
import CoreData

enum ScreenshotSampleData {
    static let launchArgument = "-ScreenshotSampleData"

    static var isEnabled: Bool {
        ProcessInfo.processInfo.arguments.contains(launchArgument)
    }

    private struct Entry {
        let name: String
        let roaster: String
        let style: String
        let beanType: String
        let buyAgain: Bool
        let boughtDaysAgo: Int
        let roastedDaysBeforePurchase: Int
        let notes: String
        let unsplashPhotoID: String?
    }

    private static let entries: [Entry] = [
        Entry(name: "Costa Rica Tarrazú",
              roaster: "Cultivate Coffee Roasters",
              style: "Light",
              beanType: "beans",
              buyAgain: true,
              boughtDaysAgo: 2,
              roastedDaysBeforePurchase: 4,
              notes: "Honey, red apple, and brown sugar. Best as a pour over at 1:16.",
              unsplashPhotoID: "1642437271884-fe1d3393eef9"),
        Entry(name: "Departure Blend",
              roaster: "Boarding Pass Coffee",
              style: "Medium",
              beanType: "beans",
              buyAgain: true,
              boughtDaysAgo: 6,
              roastedDaysBeforePurchase: 3,
              notes: "Chocolatey and smooth. My go-to for the AeroPress.",
              unsplashPhotoID: "1685798830559-c116586a0d33"),
        Entry(name: "Ethiopia Guji Natural",
              roaster: "Fieldnote Roasting Co.",
              style: "Light",
              beanType: "beans",
              buyAgain: true,
              boughtDaysAgo: 9,
              roastedDaysBeforePurchase: 5,
              notes: "Blueberry bomb. Tastes like jam when it cools down.",
              unsplashPhotoID: nil),
        Entry(name: "Brazil Cerrado",
              roaster: "Little Nap Coffee Stand",
              style: "Medium",
              beanType: "beans",
              buyAgain: true,
              boughtDaysAgo: 13,
              roastedDaysBeforePurchase: 6,
              notes: "Picked up in Tokyo. Nutty, low acidity, great with milk.",
              unsplashPhotoID: "1512372388054-a322888e67a6"),
        Entry(name: "Hayes Valley Espresso",
              roaster: "Blue Bottle Coffee",
              style: "Dark",
              beanType: "beans",
              buyAgain: false,
              boughtDaysAgo: 18,
              roastedDaysBeforePurchase: 7,
              notes: "Too roasty for straight shots, but solid in a latte.",
              unsplashPhotoID: "1605711599412-775918dbe770"),
        Entry(name: "Colombia Huila Decaf",
              roaster: "Slow Morning Coffee",
              style: "Medium",
              beanType: "grounds",
              buyAgain: true,
              boughtDaysAgo: 24,
              roastedDaysBeforePurchase: 9,
              notes: "Sugarcane decaf. Honestly can't tell the difference after 3pm.",
              unsplashPhotoID: nil),
        Entry(name: "Kenya Nyeri AA",
              roaster: "Copperline Roasters",
              style: "Light",
              beanType: "beans",
              buyAgain: true,
              boughtDaysAgo: 31,
              roastedDaysBeforePurchase: 4,
              notes: "Grapefruit and blackcurrant. Bright, juicy, a little wild.",
              unsplashPhotoID: nil),
        Entry(name: "French Roast",
              roaster: "Harbor & Pine",
              style: "Dark",
              beanType: "grounds",
              buyAgain: false,
              boughtDaysAgo: 38,
              roastedDaysBeforePurchase: 14,
              notes: "Smoky and bitter. Fine for cold brew, nothing else.",
              unsplashPhotoID: nil),
        Entry(name: "Guatemala Huehuetenango",
              roaster: "Fieldnote Roasting Co.",
              style: "Medium",
              beanType: "beans",
              buyAgain: true,
              boughtDaysAgo: 45,
              roastedDaysBeforePurchase: 5,
              notes: "Milk chocolate, almond, and a hint of orange.",
              unsplashPhotoID: nil),
        Entry(name: "Morning Ritual",
              roaster: "Daybreak Coffee Co.",
              style: "Medium",
              beanType: "pods",
              buyAgain: true,
              boughtDaysAgo: 52,
              roastedDaysBeforePurchase: 20,
              notes: "Keeps the office machine happy. Better than it has any right to be.",
              unsplashPhotoID: nil),
        Entry(name: "Sumatra Mandheling",
              roaster: "Copperline Roasters",
              style: "Dark",
              beanType: "beans",
              buyAgain: false,
              boughtDaysAgo: 60,
              roastedDaysBeforePurchase: 8,
              notes: "Earthy and heavy. Not for me, but my partner loved it.",
              unsplashPhotoID: nil),
        Entry(name: "Holiday Blend",
              roaster: "Slow Morning Coffee",
              style: "Medium",
              beanType: "beans",
              buyAgain: true,
              boughtDaysAgo: 71,
              roastedDaysBeforePurchase: 3,
              notes: "Cinnamon and dark cherry. Grab two bags next year.",
              unsplashPhotoID: nil)
    ]

    static func seed(into context: NSManagedObjectContext) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        var photosToDownload: [(bean: Bean, photoID: String)] = []

        for entry in entries {
            let boughtOn = calendar.date(byAdding: .day, value: -entry.boughtDaysAgo, to: today) ?? today
            let roastedOn = calendar.date(byAdding: .day, value: -entry.roastedDaysBeforePurchase, to: boughtOn) ?? boughtOn

            let bean = Bean(context: context)
            bean.id = UUID()
            bean.name = entry.name
            bean.roaster = entry.roaster
            bean.style = entry.style
            bean.beanType = entry.beanType
            bean.buyAgain = entry.buyAgain
            bean.boughtOn = boughtOn
            bean.roastedOn = roastedOn
            bean.notes = entry.notes
            if let photoID = entry.unsplashPhotoID {
                photosToDownload.append((bean, photoID))
            }
        }

        save(context)

        Task { @MainActor in
            for (bean, photoID) in photosToDownload {
                bean.beanPhoto = await downloadPhoto(id: photoID)
            }
            save(context)
        }
    }

    private static func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Failed to seed screenshot sample data: \(error)")
        }
    }

    private static func downloadPhoto(id: String, attempts: Int = 3) async -> Data? {
        let url = URL(string: "https://images.unsplash.com/photo-\(id)?w=1200&h=1200&fit=crop&crop=entropy&q=80&fm=jpg")!
        for attempt in 1...attempts {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                return data
            } catch {
                print("Failed to download sample photo \(id) (attempt \(attempt)/\(attempts)): \(error)")
            }
        }
        return nil
    }
}
#endif
