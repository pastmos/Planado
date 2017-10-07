//
//  OrdersListTableViewController.swift
//  Planado
//
//  Created by Past on 02.10.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import UIKit

class OrdersListTableViewController: UITableViewController {

    @IBOutlet weak var datePickerButton: UIBarButtonItem!
    
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
    
    @IBAction func datePickerButtonPressed(_ sender: Any) {
 
        let datePicker = UIDatePicker()
        let okButton = UIButton()
        let datePickerUIView = UIView()

        
        //Set some of UIView properties
        datePicker.backgroundColor = UIColor.lightGray
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.init(identifier: "ru-Cyrl")
        //Round corners for datePicker
        datePicker.layer.masksToBounds = true
        datePicker.layer.cornerRadius = 20
        datePicker.tag = 3
        
        //Set properties for OK and Cancel
        okButton.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 1, alpha: 1.0)
        okButton.layer.masksToBounds = true
        okButton.layer.cornerRadius = 15
        okButton.setTitle("Выбрать", for: .normal)
        okButton.tag = 2
        okButton.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)

        
        datePickerUIView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        datePickerUIView.tag = 1
        
        
        self.view.addSubview(datePickerUIView)
        datePickerUIView.addSubview(datePicker)
        datePickerUIView.addSubview(okButton)
        

        //Forbide to select cells in table, while interacting with DatePicker
        self.tableView.allowsSelection = false
        
        //Layout for DatePicker
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        datePickerUIView.translatesAutoresizingMaskIntoConstraints = false
        
        //set leading and trailing constraints
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            datePickerUIView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            datePickerUIView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            okButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            okButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        //Set height constraint = 0.5*viewHeight
        //Set top constraint = top of safeArea, considering iOS11 safe area for iPhoneX
        if #available(iOS 11, *) {
            let safeArea = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: safeArea.topAnchor),
            datePicker.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            datePickerUIView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            datePickerUIView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.9),
            okButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            okButton.heightAnchor.constraint(equalTo: datePicker.heightAnchor,multiplier: 0.2)
            ])
            
        } else {
            NSLayoutConstraint.activate([
            datePickerUIView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 5),
            datePickerUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
            datePicker.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 5),
            datePicker.bottomAnchor.constraint(equalTo: datePickerUIView.centerYAnchor, constant: 5),
            okButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePickerButton.title = currentDate
    }

    
    override func viewWillAppear(_ animated: Bool) {

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
    
    @objc func buttonAction(sender: UIButton!) {
        if sender.tag == 2 {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            let datepicker = self.view.viewWithTag(3) as! UIDatePicker
            currentDate = formatter.string(from: datepicker.date)
            self.datePickerButton.title = currentDate
            
            //Allow to select cells in table, while interacting with DatePicker
            self.tableView.allowsSelection = true
            self.view.viewWithTag(1)?.removeFromSuperview()
        }
    }
    
}


