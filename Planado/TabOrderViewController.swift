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
    
    var tappedCellOrder: Order = Order()
    var tappedIndex: Int!

    //Actions
    @IBAction func callButtonPressed(_ sender: BorderedButton) {
        let phone = String(describing: tappedCellOrder.customer.customerPhone)
        guard let phoneCallURL = URL(string: "tel://\(phone)")  else { return }
        UIApplication.shared.open(phoneCallURL)
            }

    @IBAction func startButtonPressed(_ sender: BorderedButton) {
        
        switch tappedCellOrder.orderInfo.orderStatus{
            
        case .NotStarted:
            orderAccomplishedStatus.text = "Выполняется"
            orderAccomplishedStatus.textColor = .orange
            startButton.setTitle("Остановить", for: .normal)
            tappedCellOrder.orderInfo.orderStatus = OrderStatusState.Started
            
        case .Started:
            orderAccomplishedStatus.text = "Остановлен"
            orderAccomplishedStatus.textColor = .red
            startButton.setTitle("Продолжить", for: .normal)
            tappedCellOrder.orderInfo.orderStatus = OrderStatusState.Delayed
        
        case .Delayed:
            orderAccomplishedStatus.text = "Выполняется"
            orderAccomplishedStatus.textColor = .orange
            startButton.setTitle("Остановить", for: .normal)
            //startButton.setTitleColor(.orange, for: .normal)
            tappedCellOrder.orderInfo.orderStatus = OrderStatusState.Started
        
        case .Completed:
            // create the alert
            let alert = UIAlertController(title: "Внимание!", message: "Данный наряд уже выполнен", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func finishButtonPressed(_ sender: BorderedButton) {
        
        //If the order is not completed or hasnt been started
        switch self.tappedCellOrder.orderInfo.orderStatus{
        case .NotStarted:
            let alert = UIAlertController(title: "Внимание!", message: "Данный наряд еще не начат", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        case .Completed:
            let alert = UIAlertController(title: "Внимание!", message: "Данный наряд уже выполнен", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        default:
        let alert = UIAlertController(title: "Завершить наряд?", message: "Завершайте наряд только если он полностью выполнен", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Завершить", style: UIAlertActionStyle.default, handler: {[weak self] action in
            self?.orderAccomplishedStatus.text = "Выполнен"
            self?.orderAccomplishedStatus.textColor = .green
            self?.tappedCellOrder.orderInfo.orderStatus = OrderStatusState.Completed
            }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)

            }
    
    }

    override func viewWillAppear(_ animated: Bool) {
        self.customerName.text = tappedCellOrder.customer.customerName
        self.customerAddress.text = tappedCellOrder.customer.customerAddress
        self.workType.text = tappedCellOrder.orderInfo.workType
        self.orderTime.text = tappedCellOrder.orderInfo.startTime
        
        switch tappedCellOrder.orderInfo.orderStatus {
        case .NotStarted:
            self.orderAccomplishedStatus.text = "Не начат"
            startButton.setTitle("Начать", for: .normal)
        case .Started:
            self.orderAccomplishedStatus.text = "Выполняется"
            orderAccomplishedStatus.textColor = .orange
            startButton.setTitle("Остановить", for: .normal)
        case .Delayed:
            self.orderAccomplishedStatus.text = "Остановлен"
            orderAccomplishedStatus.textColor = .red
            startButton.setTitle("Продолжить", for: .normal)
        case .Completed:
            self.orderAccomplishedStatus.text = "Выполнен"
            orderAccomplishedStatus.textColor = .green
            startButton.setTitle("Начать", for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        orders[tappedIndex].orderInfo.orderStatus = tappedCellOrder.orderInfo.orderStatus
    }
    
}
