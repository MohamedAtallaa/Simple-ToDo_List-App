//
//  DetailsVC.swift
//  To_Do_App
//
//  Created by Mohamed Atallah on 04/11/2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    var todo: Todo!
    var index: Int!

    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoDetailslabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if todo.image != nil {
            todoImageView.image = todo.image
        } else {
            todoImageView.image = UIImage(named: "noImage")
        }
        todoTitleLabel.text = todo.title
        todoDetailslabel.text = todo.details
        
        NotificationCenter.default.addObserver(self, selector: #selector(editedTodo), name: NSNotification.Name(rawValue: "editedTodo"), object: nil)
    }
    
    @objc func editedTodo(notification: Notification) {
        if let todo = (notification.userInfo?["todo"]) as? Todo {
            todoTitleLabel.text = todo.title
            todoDetailslabel.text = todo.details
            todoImageView.image = todo.image
        }
    }
    

    @IBAction func editButtonClicked(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "newTodo") as? NewTodoVC {
            vc.isCreation = false
            vc.editedTodo = todo
            vc.editedTodoIndex = index
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deletedTodo"), object: nil, userInfo: ["index" : index])
        let alert = UIAlertController(title: "Delete", message: "Are You Sure?!", preferredStyle: .alert)
        let alertConformAction = UIAlertAction(title: "Yes", style: .default) { _ in
            
            let alert = UIAlertController(title: "Delete", message: "Todo deleted Successfully!", preferredStyle: .alert)
            let alertClosedAction = UIAlertAction(title: "Ok", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(alertClosedAction)
            self.present(alert, animated: true)
        }
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(alertConformAction)
        alert.addAction(alertCancelAction)
        present(alert, animated: true)
       
    }
    

}
