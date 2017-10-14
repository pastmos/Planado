//
//  TabOrderViewController.swift
//  Planado
//
//  Created by Past on 13.10.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import UIKit

class TabOrderViewController: UIViewController {
    //Outlets
    @IBOutlet weak var startButton: BorderedButton!
    @IBOutlet weak var finishButton: BorderedButton!
    @IBOutlet weak var orderTime: BorderedLabel!
    @IBOutlet weak var orderAccomplishedStatus: BorderedLabel!
    
    @IBOutlet weak var customerAddress: UITextView!
    @IBOutlet weak var customerName: UITextView!
    @IBOutlet weak var workType: UITextView!
    
    var tappedCellOrder = Order()
    
    //Actions
    @IBAction func callButtonPressed(_ sender: BorderedButton) {
        
    }
    @IBAction func startButtonPressed(_ sender: BorderedButton) {
        
        
        
    }
    
    @IBAction func finishButtonPressed(_ sender: BorderedButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.customerName.text = tappedCellOrder.customerName
        self.customerAddress.text = tappedCellOrder.customerAddress
        self.workType.text = tappedCellOrder.workType
        self.orderTime.text = tappedCellOrder.startTime
        //self.orderAccomplishedStatus.text = tappedCellOrder.orderStatus
        
        switch tappedCellOrder.orderStatus {
        case .NotStarted:
            self.orderAccomplishedStatus.text = "Не начат"
        case .Started:
            self.orderAccomplishedStatus.text = "Начат"
        case .Delayed:
            self.orderAccomplishedStatus.text = "Отложен"
        }
    }
    
    
}
