//
//  ViewController.swift
//  To_Do_App
//
//  Created by Mohamed Atallah on 04/11/2022.
//

import UIKit

class TodoVC: UIViewController {
    
    var todos =
    [
        Todo(title: "First-Task", image: UIImage(systemName: "pencil.circle.fill")!),
        Todo(title: "2nd-Task", image: nil, details: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim."),
        Todo(title: "Third-Task", image: UIImage(systemName: "pencil")!),
        Todo(title: "4th-Task", image: UIImage(systemName: "pencil.circle.fill")!)
       
    ]

    @IBOutlet weak var todostableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todostableView.dataSource = self
        todostableView.delegate = self

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
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}



