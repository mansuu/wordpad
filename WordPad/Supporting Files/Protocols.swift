//
//  Protocols.swift
//  WordPad
//
//  Created by Himanshu on 27/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import Foundation
protocol InformSuperController:class {
    func sendMessage(action : String)
}
protocol DropDownOptionSelectionListener:class {
    func onSelect(option:String)
}
