//
//  CoreDataManger.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 30/08/2025.
//

import Foundation
import CoreData

class CoreDataManger {
    static let shared = CoreDataManger()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExperienceEntity") // Replace with your .xcdatamodeld name
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveExperience(experience: Experience, type: String) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.saveExperience(experience: experience, type: type)
            }
            return
        }
        let context = CoreDataManger.shared.context
        
        context.performAndWait {
            let newExperience = ExperienceEntity(context: context)
            
            newExperience.expID = experience.id
            newExperience.title = experience.title
            newExperience.cover = experience.coverPhoto
            newExperience.recommended = Int32(experience.recommended)
            newExperience.views = Int32(experience.viewsNo)
            newExperience.likes = Int32(experience.likesNo)
            newExperience.type = type
            newExperience.descriptionText = experience.description
            newExperience.tourHtml = experience.tourHml
        }

        do {
            try context.save()
        } catch {
            print("Error saving experience: \(error)")
        }
    }
    

    // Fetch experiences by type
    func fetchExperiences(type: String) -> [Experience] {
        let context = CoreDataManger.shared.context
        let fetchRequest: NSFetchRequest<ExperienceEntity> = ExperienceEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@", type)

        do {
            let result = try context.fetch(fetchRequest)
            return result.map {
                Experience(
                    id: $0.expID ?? "",
                    title: $0.title ?? "",
                    coverPhoto: $0.cover ?? "",
                    description: $0.descriptionText ?? "",
                    viewsNo: Int($0.views),
                    likesNo: Int($0.likes),
                    recommended: Int($0.recommended),
                    hasVideo: 0,
                    tourHml: $0.tourHtml ?? ""
                )
            }
        } catch {
            print("Error fetching experiences: \(error)")
            return []
        }
    }

    // Clear old experiences of a specific type
    func clearExperiences(ofType type: String) {
        let context = CoreDataManger.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ExperienceEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@", type)

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error clearing experiences: \(error)")
        }
    }
    
    func saveExperienceDetail(experience: ExperienceDetail) {
            let context = CoreDataManger.shared.context
            let newExperience = ExperienceEntity(context: context)

            newExperience.expID = experience.id
            newExperience.title = experience.title
            newExperience.cover = experience.coverPhoto
            newExperience.descriptionText = experience.description
            newExperience.views = Int32(experience.viewsNo)
            newExperience.likes = Int32(experience.likesNo)
            newExperience.recommended = Int32(experience.recommended)

            do {
                try context.save()
            } catch {
                print("Error saving experience detail: \(error)")
            }
        }

        // Fetch ExperienceDetail by ID
        func fetchExperienceDetail(withID id: String) -> ExperienceEntity? {
            let context = CoreDataManger.shared.context
            let fetchRequest: NSFetchRequest<ExperienceEntity> = ExperienceEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)

            do {
                let experiences = try context.fetch(fetchRequest)
                return experiences.first
            } catch {
                print("Error fetching experience detail by ID: \(error)")
                return nil
            }
        }

        // Clear ExperienceDetail by ID (if needed)
        func clearExperienceDetail(withID id: String) {
            let context = CoreDataManger.shared.context
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ExperienceEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)

            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
            } catch {
                print("Error clearing experience detail: \(error)")
            }
        }
    
}
