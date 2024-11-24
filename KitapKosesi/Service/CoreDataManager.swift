//
//  CoreDataManager.swift
//  KitapKosesi
//
//  Created by Kadir on 24.11.2024.
//


import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    // Ana managed object context. Bu context uygulama veritabanı ile etkileşimde bulunur.
    private  lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // Özel (private) managed object context. Bu context, arka planda işlem yaparak ana context ile veri senkronizasyonu sağlar.
     lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = mainManagedObjectContext
        return privateContext
    }()
    
    // Ana context'in değişikliklerini kaydetme işlemi
    private func saveMainContext() {
        if mainManagedObjectContext.hasChanges {
            do {
                try mainManagedObjectContext.save()
            } catch {
                print("Error saving main managed object context: \(error)")
            }
        }
    }
    
    // Özel context'in değişikliklerini kaydetme işlemi
    private func savePrivateContext() {
        if privateManagedObjectContext.hasChanges {
            do {
                try privateManagedObjectContext.save()
            } catch {
                print("Error saving private managed object context: \(error)")
            }
        }
    }
    
    // Değişiklikleri kaydetme işlemini iki context'te yapar.
    private func saveChanges() {
        savePrivateContext()
        mainManagedObjectContext.performAndWait {
            saveMainContext()
        }
    }
    
    // Verileri kaydetme fonksiyonu
    func saveData<T: NSManagedObject>(objects: [T]) {
        print("Kaydetmeye giriyorr")
        privateManagedObjectContext.perform {
            // Veriler özel context'e eklenir.
            for object in objects {
                self.privateManagedObjectContext.insert(object)
            }
            
            // Değişiklikler kaydedilir ve ana context'e aktarılır.
            self.saveChanges()
        }
    }
    
    // Verileri güncelleme fonksiyonu
    func updateData<T: NSManagedObject>(objects: [T]) {
        privateManagedObjectContext.perform {
            // Veriler özel context'te güncellenir.
            for object in objects {
                if object.managedObjectContext == self.privateManagedObjectContext {
                    // Eğer nesne zaten özel context'te ise, doğrudan güncellenir.
                    object.managedObjectContext?.refresh(object, mergeChanges: true)
                } else {
                    // Eğer nesne özel context'te değilse, önce veritabanından çekilip güncellenir.
                    let fetchRequest = NSFetchRequest<T>(entityName: object.entity.name!)
                    fetchRequest.predicate = NSPredicate(format: "SELF == %@", object)
                    fetchRequest.fetchLimit = 1
                    
                    if let fetchedObject = try? self.privateManagedObjectContext.fetch(fetchRequest).first {
                        fetchedObject.setValuesForKeys(object.dictionaryWithValues(forKeys: object.entity.attributesByName.keys.map { $0 }))
                    }
                }
            }
            
            // Değişiklikler kaydedilir ve ana context'e aktarılır.
            self.saveChanges()
        }
    }
    
    // Verileri silme fonksiyonu
    func deleteData<T: NSManagedObject>(objects: [T]) {
        privateManagedObjectContext.perform {
            // Veriler özel context'ten silinir.
            for object in objects {
                if object.managedObjectContext == self.privateManagedObjectContext {
                    self.privateManagedObjectContext.delete(object)
                } else {
                    if let objectInContext = self.privateManagedObjectContext.object(with: object.objectID) as? T {
                        self.privateManagedObjectContext.delete(objectInContext)
                    }
                }
            }
            
            // Değişiklikler kaydedilir ve ana context'e aktarılır.
            self.saveChanges()
        }
    }
    
    func fetchAllData<T: NSManagedObject>(entity: T.Type) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entity))
        
        do {
            let result = try mainManagedObjectContext.fetch(fetchRequest)
            return result
        } catch {
            print("Error fetching all data for entity \(String(describing: entity)): \(error)")
            return []
        }
    }
    
    func fetchObjectById<T: NSManagedObject>(entity: T.Type, id: String) -> T? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entity))
        fetchRequest.predicate = NSPredicate(format: "id == %@", id) // id'yi kontrol et

        do {
            let result = try mainManagedObjectContext.fetch(fetchRequest)
            return result.first // İlk eşleşen nesneyi döndür
        } catch {
            print("Error fetching object with id \(id): \(error)")
            return nil
        }
    }
    
}
