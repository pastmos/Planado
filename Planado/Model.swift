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
var currentDateForOrdersList = Date()
let ordersData = [ Order(time:"11:00 - 12:00", workType:"Замена роутера на оборудование абонента", customerName: "Иванов И.И.", customerAddress: "Москва, Полянка,2", customerPhone: "+7(903)1245506"), Order(time:"12:00 - 13:00", workType:"Подключение ТВ", customerName: "Петров И.И.", customerAddress: "Москва, Земляной вал,13, стр.6/1", customerPhone: "+7(903)1245506"), Order(time:"13:00 - 14:00", workType:"Прокладка провода", customerName: "Сидоров И.И.", customerAddress: "Москва, мал.Никитская,21", customerPhone: "+7(903)1245506") , Order(time:"14:00 - 15:00", workType:"Настройка роутера", customerName: "Панов И.И.", customerAddress: "Москва, МЖК,533, кв.82, сразу за Каштановой аллеей повернуть направо, нумерация подъездов обратная!", customerPhone: "+7(903)1245506"), Order(time:"15:00 - 16:00", workType:"Настройка WiFi", customerName: "Зейдельбаум И.И.", customerAddress: "Москва, Ленинградский просп.,43б вход со двора, после электроподстанции повернуть во двор ", customerPhone: "+7(903)1245506")]



class Order: NSObject {
    var startTime: String
    var workType: String
    var customerName: String
    var customerAddress: String
    var customerPhone: String

    
    init(time: String, workType: String, customerName: String, customerAddress: String, customerPhone: String) {
        self.startTime = time
        self.workType = workType
        self.customerName = customerName
        self.customerAddress = customerAddress
        self.customerPhone = customerPhone
        super.init()
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





