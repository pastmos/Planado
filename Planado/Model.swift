//
//  Model.swift
//  Planado
//
//  Created by Past on 28.09.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import Foundation
import UIKit

class Order: NSObject {
    var startTime: String
    var workType: String
    var customerName: String
    var customerAddress: String
    
    init(time: String, workType: String, customerName: String, customerAddress: String) {
        self.startTime = time
        self.workType = workType
        self.customerName = customerName
        self.customerAddress = customerAddress
        super.init()
    }
}
let ordersData = [ Order(time:"11:00 - 12:00", workType:"Замена роутера на оборудование абонента", customerName: "Иванов И.И.", customerAddress: "Москва, Полянка,2"), Order(time:"12:00 - 13:00", workType:"Подключение ТВ", customerName: "Петров И.И.", customerAddress: "Москва, Земляной вал,13, стр.6/1"), Order(time:"13:00 - 14:00", workType:"Прокладка провода", customerName: "Сидоров И.И.", customerAddress: "Москва, мал.Никитская,21") , Order(time:"14:00 - 15:00", workType:"Настройка роутера", customerName: "Панов И.И.", customerAddress: "Москва, МЖК,533, кв.82, сразу за Каштановой аллеей повернуть направо, нумерация подъездов обратная!"), Order(time:"15:00 - 16:00", workType:"Настройка WiFi", customerName: "Зейдельбаум И.И.", customerAddress: "Москва, Ленинградский просп.,43б вход со двора, после электроподстанции повернуть во двор ")]

var orders: [Order] = ordersData
