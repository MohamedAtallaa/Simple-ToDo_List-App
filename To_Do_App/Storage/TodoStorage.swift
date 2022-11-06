//
//  TodoStorage.swift
//  To_Do_App
//
//  Created by Mohamed Atallah on 06/11/2022.
//

import Foundation
import UIKit
import CoreData

class TodoStorage {
    
    static func storeData(todo: Todo) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContext = appdelegate.persistentContainer.viewContext
        guard let todoEntity = NSEntityDescription.entity(forEntityName: "TodoEntity", in: manageContext) else { return }
        let todoObject = NSManagedObject.init(entity: todoEntity, insertInto: manageContext)
        todoObject.setValue(todo.title, forKey: "title")
        todoObject.setValue(todo.details, forKey: "details")
        if let image = todo.image {
            let imageData = image.jpegData(compressionQuality: 1)
            todoObject.setValue(imageData, forKey: "image")
        }
        
        do {
            try manageContext.save()
            print("========success=========")
        }catch {
            print("=========error==========")
        }
    }
    
    
    static func getTodos() -> [Todo] {
        
        var todos: [Todo] = []
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoEntity")
        
        do {
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for managedTodo in result {
                let title = managedTodo.value(forKey: "title") as? String
                let details = managedTodo.value(forKey: "details") as? String
                
                var todoImage: UIImage? = nil
                if let imageFromContext = managedTodo.value(forKey: "image") as? Data {
                    todoImage = UIImage(data: imageFromContext)
                }
                
                let todo = Todo(title: title ?? "",image: todoImage, details: details ?? "")
                todos.append(todo)
            }
        }catch {
            print("==========Error==========")
        }
        
        return todos
    }
    
    
    static func updateTodo(todo: Todo, index: Int) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoEntity")
        
        do {
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            result[index].setValue(todo.title, forKey: "title")
            result[index].setValue(todo.details, forKey: "details")
            if let image = todo.image {
                let imageData = image.jpegData(compressionQuality: 1)
                result[index].setValue(imageData, forKey: "image")
            }
            try context.save()
        }catch {
            print("======Error=====")
        }
    }
    
    static func todoDeleted(index: Int) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoEntity")
        
        do {
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            let deletedTodo = result[index]
            context.delete(deletedTodo)
            
            try context.save()
        }catch {
            print("========Error=======")
        }
    }
}

