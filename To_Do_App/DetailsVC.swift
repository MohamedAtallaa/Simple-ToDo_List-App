//
//  DetailsVC.swift
//  To_Do_App
//
//  Created by Mohamed Atallah on 04/11/2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    var todo: Todo!

    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoDetailsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if todo.image != nil {
            todoImageView.image = todo.image
        } else {
            todoImageView.image = UIImage(named: "noImage")
        }
        todoTitleLabel.text = todo.title
        todoDetailsTextView.text = todo.details
    }
    

    @IBAction func editButtonClicked(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
