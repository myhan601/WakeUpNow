//
//  CoreDataManager.swift
//  WakeUpNow
//
//  Created by SAMSUNG on 5/17/24.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    var persistent: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    func saveUser(user: User) {
        guard let context = self.persistent?.viewContext else { return }
        let newPd = UserData(context: context)
        newPd.score = Int64(user.score)
        try? context.save()
    }
    
    func readUser() -> [User] {
        var read: [User] = []
        guard let context = self.persistent?.viewContext else { return [] }
        let request = UserData.fetchRequest()
        let loadData = try? context.fetch(request)
        for i in loadData! {
            read.append(User(score: Int(i.score)))
        }
        return read
    }
    
    func deleteUser(num: Int) {
        guard let context = self.persistent?.viewContext else { return }
        let request = UserData.fetchRequest()
        guard let loadData = try? context.fetch(request) else { return }
        let filtered = loadData[num]
        context.delete(filtered)
        try? context.save()
    }
}
