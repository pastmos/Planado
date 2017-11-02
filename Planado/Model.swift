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

//var order = Order(customer: customer,orderInfo: orderInfo, photosList: photosList,taskList: taskList)

//var orders: [Order] = ordersData
//
//let ordersData = [ Order(orderNumber: "34", time:"11:00 - 12:00", workType:"Замена роутера на оборудование абонента", customerName: "Иванов И.И.", customerAddress: "Москва, Полянка,2", customerPhone: "+7(905)7264547"), Order(orderNumber: "35654", time:"12:00 - 13:00", workType:"Подключение ТВ", customerName: "Петров И.И.", customerAddress: "Москва, Земляной вал,13, стр.6/1", customerPhone: "+7(903)1245506"), Order(orderNumber: "87456", time:"13:00 - 14:00", workType:"Прокладка провода", customerName: "Сидоров И.И.", customerAddress: "Москва, мал.Никитская,21", customerPhone: "+7(903)1245506") , Order(orderNumber: "85", time:"14:00 - 15:00", workType:"Настройка роутера", customerName: "Панов И.И.", customerAddress: "Москва, МЖК,533, кв.82, сразу за Каштановой аллеей повернуть направо, нумерация подъездов обратная!", customerPhone: "+7(903)1245506"), Order(orderNumber: "74", time:"15:00 - 16:00", workType:"Настройка WiFi", customerName: "Зейдельбаум И.И.", customerAddress: "Москва, Ленинградский просп.,43б вход со двора, после электроподстанции повернуть во двор ", customerPhone: "+7(903)1245506")]


var currentDateForOrdersList = Date()
var currentDate : String!

//Pictures for orderStatus icon
let startedImage = UIImage(named: "in_progress64.png")
let notStartedImage = UIImage(named: "not_in_progress64.png")
let delayedImage = UIImage(named: "delayed64.png")
let completedImage = UIImage(named: "completed64.png")

func orderInit()
{
    orders.append(order)
}

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
    func setValueListener(sender: NSObject)
    {
        
        if let senderVC = sender as? UITableViewController {
        var ordersIDList = [String]()
        var dateSelectedOrderCounter = 0
            
        //lets get full list of orders IDs(order1,order2,....)
        self.ref.observe(.value, with: { snapshot in
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

                        if parsedOrder.orderInfo.orderDate == currentDate{
                        orders.append(Order())
                        orders[dateSelectedOrderCounter] = parsedOrder
                        
                        
                        
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
                    let orderNumber = Int(snapshot.key)
                    //print(nodeSnapshots)
                    //parsing orders data from Firebase one by one

                    
//                let artist = snapshot.childSnapshot(forPath: "artist").value as! String
//                let title = snapshot.childSnapshot(forPath: "title").value as! String
//                let picture = snapshot.childSnapshot(forPath: "picture").value as! String
//                let vidURL = snapshot.childSnapshot(forPath: "url").value as! String
//
//                print("\(artist) \n\(title) \n\(picture) \n\(vidURL)")
//
//                let youtubeURL = NSURL(string: vidURL)
//                let youtubeRequest = NSMutableURLRequest(url: youtubeURL! as URL)
//                youtubeRequest.setValue("https://www.youtube.com", forHTTPHeaderField: "Referer")
//
//                let p1 = AddCell(imageURL: picture ,
//                                 videoURL: youtubeRequest,
//                                 songTitle: title,
//                                 artistName: artist)
//
//                self.addCells.append(p1)
                let x = 3
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

func parseOrder(snapshots: [DataSnapshot]) -> Order{

    order = Order()
    for nodeSnap in snapshots{
    if let postDict = nodeSnap.value as? Dictionary<String, String> {
        
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
                order.photosList.append(postDict["url" + String(index+1)]!)
                
            }
        case "tasklist":
            //order.photosList.status = postDict["description"]!
            let x = 4
        default:
            let x = 4
            
        }
        
    }
    else{
        //let postDict = nodeSnap.value as? String{
        //print(nodeSnap.key)
        let x = 4
        
    }
}
    return order
}
