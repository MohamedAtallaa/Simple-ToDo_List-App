//
//  NewTodoVC.swift
//  To_Do_App
//
//  Created by Mohamed Atallah on 04/11/2022.
//

import UIKit

class NewTodoVC: UIViewController {
    
    var isCreation: Bool = true
    var editedTodo: Todo!
    var editedTodoIndex: Int!
    
    
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCreation == false {
            editButton.setTitle("Edit", for: .normal)
            navigationItem.title = "Edit Todo"
        }
        
        if let editedTodo = editedTodo {
            todoImageView.image = editedTodo.image
            titleTextField.text = editedTodo.title
            detailsTextView.text = editedTodo.details
        }
    }
    
    @IBAction func changePhotoButtonClicked(_ sender: Any) {
        // Open the studio in my my phone
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
        if isCreation {
            let todo = Todo(title: titleTextField.text!, image: todoImageView.image, details: detailsTextView.text)
            // post Notification
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addedNewTodo"), object: nil, userInfo: ["todo" : todo])
            
            let alert = UIAlertController(title: "Add New Todo", message: "New Todo added Successfully", preferredStyle: UIAlertController.Style.alert)
            let alertClosedAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
                
                // move to the todoList page
                self.tabBarController?.selectedIndex = 0
            }
            alert.addAction(alertClosedAction)
            present(alert, animated: true)
            
        } else {
            
            let todo = Todo(title: titleTextField.text!, image: todoImageView.image, details: detailsTextView.text)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "editedTodo"), object: nil, userInfo: ["index" : editedTodoIndex, "todo" : todo])
            
            let alert = UIAlertController(title: "Editing Todo", message: "Todo edited successfully", preferredStyle: .alert)
            let alertClosedAction = UIAlertAction(title: "Ok", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(alertClosedAction)
            present(alert, animated: true)
            
        }
    }
    
}

extension NewTodoVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // function that call after choosing image from sudio
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickingImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        dismiss(animated: true)
        todoImageView.image = pickingImage
    }
    
}
