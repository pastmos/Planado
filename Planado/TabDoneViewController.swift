//
//  TabDoneViewController.swift
//  Planado
//
//  Created by Past on 13.10.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import UIKit
import FirebaseDatabase


class TabDoneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var orderVC : TabOrderViewController!
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        //to get TabOrderViewController variables
        orderVC = self.tabBarController?.viewControllers![0] as? TabOrderViewController
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders[orderVC.tappedIndex].taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCellIdentifier", for: indexPath) as! TaskCell
        
        //show completed or uncompleted status while filling tabel
        cell.taskText.text = orders[orderVC.tappedIndex].taskList[indexPath.row].description
        if orders[orderVC.tappedIndex].taskList[indexPath.row].status == "false"{
         cell.taskCompletedImage.image = UIImage(named: "Uncompleted.png")
        }
        if orders[orderVC.tappedIndex].taskList[indexPath.row].status == "true"{
         cell.taskCompletedImage.image = UIImage(named: "Completed.png")
        }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TaskCell
        let cellImage = cell.taskCompletedImage
        let status = orders[orderVC.tappedIndex].taskList[indexPath.row].status
        
        let orderID = String(ordersDictList[orderVC.tappedIndex]! + 1)
        let taskID = String(indexPath.row + 1)
        
        if status == "false"{
            cellImage?.image = UIImage(named: "Completed.png")
            orders[orderVC.tappedIndex].taskList[indexPath.row].status = "true"
            self.ref.child("orders").child(orderID).child("tasklist").child(taskID).updateChildValues(["status": "true"])
        }
        if status == "true"{
            cellImage?.image = UIImage(named: "Uncompleted.png")
            orders[orderVC.tappedIndex].taskList[indexPath.row].status = "false"
            self.ref.child("orders").child(orderID).child("tasklist").child(taskID).updateChildValues(["status": "false"])
        }

    }

}
