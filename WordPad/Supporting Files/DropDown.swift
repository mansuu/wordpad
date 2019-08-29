//
//  DropDown.swift
//  WordPad
//
//  Created by Himanshu on 27/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import Foundation
import UIKit
class DropDown : UIButton{
    var dropDownView = DropDownView()
    var height = NSLayoutConstraint()
    var isOPen = false
    weak var informSuperController : InformSuperController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropDownView = DropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropDownView.translatesAutoresizingMaskIntoConstraints = false
        dropDownView.dropDownOptionSelectionListener = self
    }
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropDownView)
        self.superview?.bringSubviewToFront(dropDownView)
        dropDownView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropDownView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropDownView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropDownView.heightAnchor.constraint(equalToConstant: 0)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOPen{
            if let informSuperController = self.informSuperController{
                informSuperController.sendMessage(action: "enabletextbox")
            }
            closeDropDown()
        }
        else{
            if let informSuperController = self.informSuperController{
                informSuperController.sendMessage(action: "disbletextbox")
            }
            isOPen = true
            NSLayoutConstraint.deactivate([self.height])
            if self.dropDownView.tableView.contentSize.height > 200{
                height.constant = 200
            }
            else{
                height.constant = self.dropDownView.tableView.contentSize.height
            }
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.dropDownView.layoutIfNeeded()
                self.dropDownView.center.y += self.dropDownView.frame.height/2
            }, completion: nil)
        }
    }
    //MARK: - Close the Opened drop down
    func closeDropDown(){
        isOPen = false
        NSLayoutConstraint.deactivate([self.height])
        height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.dropDownView.center.y -= self.dropDownView.frame.height/2
            self.dropDownView.layoutIfNeeded()
        }, completion: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("This method has not been implemented")
    }
}

extension DropDown : DropDownOptionSelectionListener{
    func onSelect(option: String) {
        closeDropDown()
        if let informSuperController = self.informSuperController{
            informSuperController.sendMessage(action: option)
        }
    }
    
 
}
