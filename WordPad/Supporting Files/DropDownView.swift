//
//  DropDownView.swift
//  WordPad
//
//  Created by Himanshu on 27/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import Foundation
import UIKit
class DropDownView : UIView, UITableViewDelegate, UITableViewDataSource{
    var options = [String]()
    var tableView = UITableView()
    weak var dropDownOptionSelectionListener : DropDownOptionSelectionListener?
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("this method has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dropDownOptionSelectionListener = self.dropDownOptionSelectionListener{
            dropDownOptionSelectionListener.onSelect(option: options[indexPath.row])
        }
    }
}
