//
//  ViewController.swift
//  davaleba-13
//
//  Created by Ladolado3911 on 12/12/20.
//

import UIKit

class FirstPage: UIViewController {
    
    var database = [String]()
        
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var add: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table1.dataSource = self
        table1.delegate = self
        
        let right_button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(act))
        navigationItem.setRightBarButton(right_button, animated: true)

    }
    
    @objc func act(_ sender: UIBarButtonItem) {
        table1.isEditing = !table1.isEditing
        sender.title = table1.isEditing ? "Done" : "Edit"
    }
    
    
    @IBAction func btt(_ sender: Any) {
        
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondPage") as? SecondPage
        
        vc2?.delegate = self
        
        
        self.present(vc2!, animated: true, completion: nil)
    }
    

}

extension FirstPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table1.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "\(database[indexPath.row])"
          
        return cell
    }

}

extension FirstPage: UITableViewDelegate {
    //
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = database.remove(at: sourceIndexPath.row)
        database.insert(temp, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "remove") { (action, view, completion) in
            print("remove")
            view.backgroundColor = .red
            
            self.database.remove(at: indexPath.row)
            self.table1.deleteRows(at: [indexPath], with: .right)
        
        }
        
        let edit = UIContextualAction(style: .normal, title: "edit") {action, view, completion in
            
            print("edit")
            view.backgroundColor = .blue
        
            
        }
        
        action.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [action, edit])
        
    }
}

extension FirstPage: AddThing {
    func addthing(_ str: String) {
        self.dismiss(animated: true) {
            self.database.append(str)
            self.table1.reloadData()
        }

    }
}

