//
//  ViewController.swift
//  To_Do_App
//
//  Created by Mohamed Atallah on 04/11/2022.
//

import UIKit

class TodoVC: UIViewController {
    
    var todos: [Todo] = []
  

    @IBOutlet weak var todostableView: UITableView!

    override func viewDidLoad() {
        self.todos = TodoStorage.getTodos()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todostableView.dataSource = self
        todostableView.delegate = self
        
        // New Todo observer notification
        NotificationCenter.default.addObserver(self, selector: #selector(addedNewTodo), name: NSNotification.Name(rawValue: "addedNewTodo"), object: nil)
        
        // Delete Todo observer notification
        NotificationCenter.default.addObserver(self, selector: #selector(deletedTodo), name: NSNotification.Name(rawValue: "deletedTodo"), object: nil)
        
        // Edited Todo observer notification
        NotificationCenter.default.addObserver(self, selector: #selector(editedTodo), name: NSNotification.Name(rawValue: "editedTodo"), object: nil)

    }
    
    @objc func addedNewTodo(notifictaion: Notification) {
        let todo = (notifictaion.userInfo?["todo"]) as? Todo
        
        if let todo = todo {
            todos.append(todo)
            todostableView.reloadData()
            TodoStorage.storeData(todo: todo)
        }
    }
    
    @objc func deletedTodo(notification: Notification) {
        if let index = (notification.userInfo?["index"]) as? Int {
            todos.remove(at: index)
            todostableView.reloadData()
            TodoStorage.todoDeleted(index: index)
        }
    }
    
    @objc func editedTodo(notification: Notification) {
        if let index = (notification.userInfo?["index"]) as? Int,
           let todo = (notification.userInfo?["todo"]) as? Todo
        {
            todos[index] = todo
            todostableView.reloadData()
            TodoStorage.updateTodo(todo: todo, index: index)
        }
    }
    


}

extension TodoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoCell
        let currentTodo = todos[indexPath.row]
                
        cell.taskTitleLabel.text = currentTodo.title
        
        if currentTodo.image != nil {
            cell.taskImageView.image = currentTodo.image
        } else {
            cell.taskImageView.image = UIImage(named: "noImage")
        }
        
        cell.taskImageView.layer.cornerRadius = cell.taskImageView.frame.width / 2
        
        return cell
    }
    
}

extension TodoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deselect the row after clicked it
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC {
            
            vc.todo = todos[indexPath.row]
            vc.index = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}



