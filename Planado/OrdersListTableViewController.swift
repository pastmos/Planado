//
//  OrdersListTableViewController.swift
//  Planado
//
//  Created by Past on 02.10.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import UIKit

class OrdersListTableViewController: UITableViewController {

    @IBAction func backButton(_ sender: Any) {
        //First method is to dissmis current controller and go back to previous automatically
        //in completion closure you can do any actions you want before dismissing current controller
        self.dismiss(animated: true, completion: nil)
        
//        //Second method is to jump to any specified controller
//        //and you must set Storyboard ID in Identity Inspector as LoginViewControllerID for LoginViewController before to avoid black screen and to define identifier for instantiateViewController method
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerID")
//        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func viewWillAppear(_ animated: Bool) {
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath) as! OrderCell
        
        let order = orders[indexPath.row] as Order
        cell.startTime?.text = order.startTime
        cell.workType?.text = order.workType
        cell.customerName?.text = order.customerName
        cell.customerAddress?.text = order.customerAddress
        
        return cell
    }
  

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

