//
//  Model.swift
//  Planado
//
//  Created by Past on 28.09.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

var orders = [Order]()
var selectedOrder = Order()
var order = Order()






var customer = Customer(customerName: "Аксенов Н.П.", customerAddress: "ул.Земляной Вал, дом 45, стр.1", customerPhone: "+7(926)4566578")
var orderInfo = OrderInfo(employeeID: "passt@yandex.ru", startTime: "17:30 - 18:50", workType: "Прокладка кабеля и установка роутера клиента", orderNumber: "874", orderDate: "26.10.17", orderStatus: .NotStarted)
var photosList : [String] = ["http://192.0.0.1","http://192.0.0.2"]
var task1 = Task(description: "Поблагодарить клиента", status: "false")
var task2 = Task(description: "Сделать фотографии готовой работы", status: "false")
var taskList : [Task] = [task1, task2]

var currentDateForOrdersList = Date()
var currentDate : String!

//Pictures for orderStatus icon
let startedImage = UIImage(named: "in_progress64.png")
let notStartedImage = UIImage(named: "not_in_progress64.png")
let delayedImage = UIImage(named: "delayed64.png")
let completedImage = UIImage(named: "completed64.png")

//orders dictionary, where first Int is order number in Firebase and the second one is appropriate number in local orders array
var ordersDictList = [Int:Int]()

enum OrderStatusState {
    case NotStarted
    case Delayed
    case Started
    case Completed
}

class Customer
{
    var customerName: String = ""
    var customerAddress: String = ""
    var customerPhone: String = ""

    init(){

    }

    init(customerName: String, customerAddress: String, customerPhone: String)
    {
        self.customerName = customerName
        self.customerAddress = customerAddress
        self.customerPhone = customerPhone
    }
}

class OrderInfo
{
    var employeeID: String = ""
    var startTime: String = ""
    var workType: String = ""
    var orderNumber: String = ""
    var orderDate: String = ""
    var orderStatus: OrderStatusState = .NotStarted
    
    init(){
        
    }
    init(employeeID: String, startTime: String, workType: String, orderNumber: String, orderDate: String, orderStatus: OrderStatusState)
    {
        self.employeeID = employeeID
        self.startTime = startTime
        self.workType = workType
        self.orderNumber = orderNumber
        self.orderDate = orderDate
        self.orderStatus = orderStatus
    }
}

class Task
{
    var description: String = ""
    var status: String = ""
    
    init(){
        
    }

    init(description: String, status: String)
    {
        self.description = description
        self.status = status
    }
}



class Order{
    var customer: Customer = Customer()
    var orderInfo: OrderInfo = OrderInfo()
    var photosList: [String] = []
    var taskList: [Task] = []
    
    init()
    {
        
    }
    init(customer: Customer, orderInfo: OrderInfo, photosList: [String], taskList: [Task]) {
        self.customer = customer
        self.orderInfo = orderInfo

        for index in 0...(photosList.count-1){
            self.photosList.append(photosList[index])
        }

        for index in 0...(taskList.count-1){
            self.taskList.append(taskList[index])
        }

    }

}


func GetCurrentDate() -> String{
    let someDateTime = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yy"
    let date = formatter.string(from: someDateTime)
    return date
}

//Customize bordered button and add properties to storyboard options
@IBDesignable class BorderedButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
}

//Customize bordered label and add properties to storyboard options
@IBDesignable class BorderedLabel: UILabel {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

}

//handles all FireBase observers list
//.value
//.childAdded
//.childChanged
class FirebaseObservers
{
    let ref = Database.database().reference().child("orders")
    var valueHandler: UInt?
    var childChangedHandler: UInt?
    
    //handles .value event observer for Firbase
    //-sender: VC, who calls func
    func setValueListener(sender: NSObject, currentEmployee: String)
    {

        if let senderVC = sender as? UITableViewController {
        var ordersIDList = [String]()
        ordersDictList = [:]
        var dateSelectedOrderCounter = 0

        //lets get full list of orders IDs(order1,order2,....)
        self.ref.observeSingleEvent(of: .value, with: { snapshot in
            if let orderSnapshots = snapshot.children.allObjects as? [DataSnapshot] {
                //reset orders list
                ordersIDList = [String]()
                //counter for orders with particular date
                var dateSelectedOrderCounter = 0
                
                for orderSnap in orderSnapshots
                {
                    ordersIDList.append(orderSnap.key)
                }
            }
            
            //init empty array of orders to fill with FireBase data

            
            //lets get data from orders records
            for ordersCount in 0...(ordersIDList.count-1){
                self.ref.child(ordersIDList[ordersCount]).observeSingleEvent(of: .value, with: { snapshot in
                    //parsing orders data from Firebase one by one
                    if let nodeSnapshots = snapshot.children.allObjects as? [DataSnapshot] {
                        let parsedOrder = parseOrder(snapshots: nodeSnapshots)
                        
                            if (parsedOrder.orderInfo.orderDate == currentDate) && (parsedOrder.orderInfo.employeeID == currentEmployee){
                                orders.append(Order())
                                orders[dateSelectedOrderCounter] = parsedOrder
                                
                                //filling dict Firebase orders list -> selected by date and employee local orders list
                                ordersDictList[dateSelectedOrderCounter] = ordersCount
                                dateSelectedOrderCounter += 1
                            }
                        
                        
                        //reload new data to tableView
                        senderVC.tableView?.reloadData()                    }
                })

            }

        })
    }
    }
    
    
    
    //handles .valueChanged event observer for Firbase
    //-sender: VC, who calls func
    func setChildChangedListener(sender: NSObject)
    {

        if let senderVC = sender as? UITableViewController {
        
            childChangedHandler = self.ref.observe(.childChanged, with: { (snapshot: DataSnapshot) in
                if let nodeSnapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    
                    let parsedOrder = parseOrder(snapshots: nodeSnapshots)
                        for orderNum in 0..<orders.count{
                            if orders[orderNum].orderInfo.orderNumber == parsedOrder.orderInfo.orderNumber{
                                orders[orderNum] = parsedOrder
                                
                                //reload particular row that has changed
                                reloadRowInSection(row: orderNum, section: 0, animation: .left, senderVC:  senderVC)
                            }
                        }
                }
            })
    }
}
    
    //remove particular observer
    func removeValueListener(handler: UInt?){
        if handler != nil{
            ref.removeObserver(withHandle: handler!)
        }
    }
    
    //remove all
    func removeAllObservers(){
    removeAllObservers()
    }
    
    
    
}

func reloadRowInSection( row: Int, section: Int, animation: UITableViewRowAnimation, senderVC: UITableViewController ){
    let indexPath = IndexPath(row: row, section: section)
    senderVC.tableView?.beginUpdates()
    senderVC.tableView?.reloadRows(at: [indexPath], with: animation)
    senderVC.tableView?.endUpdates()
}

func parseOrder(snapshots: [DataSnapshot]) -> Order{
    
    order = Order()
    
    for nodeSnap in snapshots{
        
        if let postDict = nodeSnap.value as? Dictionary<String, String> {
            //print(nodeSnap.key)
            switch nodeSnap.key{
                
            case "customer":
                order.customer.customerAddress = postDict["customerAddress"]!
                order.customer.customerPhone = postDict["customerPhone"]!
                order.customer.customerName = postDict["customerName"]!
                
            case "orderinfo":
                order.orderInfo.employeeID = postDict["employeeID"]!
                order.orderInfo.orderDate = postDict["orderDate"]!
                order.orderInfo.orderNumber = postDict["orderNumber"]!
                order.orderInfo.startTime = postDict["startTime"]!
                order.orderInfo.workType = postDict["workType"]!
                let status = postDict["orderStatus"]!
                switch(status){
                    
                case "NotStarted":
                    order.orderInfo.orderStatus = .NotStarted
                case "Started":
                    order.orderInfo.orderStatus = .Started
                case "Delayed":
                    order.orderInfo.orderStatus = .Delayed
                case "Completed":
                    order.orderInfo.orderStatus = .Completed
                default:
                    order.orderInfo.orderStatus = .NotStarted
                }
                
            case "photoslist":
                for index in 0...(postDict.count-1){
                    order.photosList.append(postDict["url" + String(index+1)]! )
                    
                }
                
            default:
                break
                
            }
        }
        
        if nodeSnap.key == "tasklist"
        {
            let nodeSnapshots = nodeSnap.children.allObjects as! [DataSnapshot]
            for index in 0..<nodeSnapshots.count{
                if let snapDict = nodeSnapshots[index].value as? Dictionary<String, String> {
                    //declare task here unless append will use the same task variable because of it's class reference type, and all task var changes'll be applied to all array members
                    let task = Task()
                    task.description = snapDict["description"]!
                    task.status = snapDict["status"]!
                    order.taskList.append(task)
                }
            }
        }
        
        
    }
    return order
}
