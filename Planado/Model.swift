//
//  Model.swift
//  Planado
//
//  Created by Past on 28.09.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import Foundation
import UIKit

var orders: [Order] = ordersData

let ordersData = [ Order(orderNumber: "34", time:"11:00 - 12:00", workType:"Замена роутера на оборудование абонента", customerName: "Иванов И.И.", customerAddress: "Москва, Полянка,2", customerPhone: "+7(905)7264547"), Order(orderNumber: "35654", time:"12:00 - 13:00", workType:"Подключение ТВ", customerName: "Петров И.И.", customerAddress: "Москва, Земляной вал,13, стр.6/1", customerPhone: "+7(903)1245506"), Order(orderNumber: "87456", time:"13:00 - 14:00", workType:"Прокладка провода", customerName: "Сидоров И.И.", customerAddress: "Москва, мал.Никитская,21", customerPhone: "+7(903)1245506") , Order(orderNumber: "85", time:"14:00 - 15:00", workType:"Настройка роутера", customerName: "Панов И.И.", customerAddress: "Москва, МЖК,533, кв.82, сразу за Каштановой аллеей повернуть направо, нумерация подъездов обратная!", customerPhone: "+7(903)1245506"), Order(orderNumber: "74", time:"15:00 - 16:00", workType:"Настройка WiFi", customerName: "Зейдельбаум И.И.", customerAddress: "Москва, Ленинградский просп.,43б вход со двора, после электроподстанции повернуть во двор ", customerPhone: "+7(903)1245506")]

var currentDateForOrdersList = Date()

//Pictures for orderStatus icon
let startedImage = UIImage(named: "in_progress64.png")
let notStartedImage = UIImage(named: "not_in_progress64.png")
let delayedImage = UIImage(named: "delayed64.png")
let completedImage = UIImage(named: "completed64.png")

enum OrderStatusState {
    case NotStarted
    case Delayed
    case Started
    case Completed
}

class Order{
    var orderNumber: String?
    var startTime: String?
    var workType: String?
    var customerName: String?
    var customerAddress: String?
    var customerPhone: String?
    var orderStatus: OrderStatusState
    
    
    init(orderNumber: String, time: String, workType: String, customerName: String, customerAddress: String, customerPhone: String) {
        self.orderNumber = orderNumber
        self.startTime = time
        self.workType = workType
        self.customerName = customerName
        self.customerAddress = customerAddress
        self.customerPhone = customerPhone
        self.orderStatus = OrderStatusState.NotStarted
    }
    init() {
        self.orderStatus = OrderStatusState.NotStarted
    }
}


var currentDate : String!

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


