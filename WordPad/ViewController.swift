//
//  ViewController.swift
//  WordPad
//
//  Created by Himanshu on 27/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    @IBOutlet weak var poarentView: UIView!
    @IBOutlet weak var changFontStackView: UIStackView!
    @IBOutlet weak var btnBold: UIButton!
    @IBOutlet weak var btnItalic: UIButton!
    var isBoldSelected = false
    var isItalicSelected = false
    var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    var textBox:UITextView={
        let textView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = UIColor.black
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.isScrollEnabled = true
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
        textView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        return textView
    }()
    var dropDown : DropDown = {
        let dropDown = DropDown(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.setTitle("Fonts", for: .normal)
        dropDown.backgroundColor = UIColor.darkGray
        dropDown.titleLabel?.textColor = UIColor.white
        dropDown.dropDownView.options = ["Ariel", "Helvetica", "Courier", "Verdana"]
        return dropDown
    }()
    var insertImageButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "insert_image"), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addDoneButtonOnKeyboard()
    }
    
    //Set up initial views
    func setupViews(){
        dropDown.informSuperController = self
        poarentView.backgroundColor = UIColor.white
        poarentView.addSubview(textBox)
        textBox.topAnchor.constraint(equalTo: changFontStackView.bottomAnchor, constant: 12).isActive = true
        textBox.leftAnchor.constraint(equalTo: poarentView.leftAnchor, constant: 12).isActive = true
        textBox.rightAnchor.constraint(equalTo: poarentView.rightAnchor, constant: -12).isActive = true
        textBox.bottomAnchor.constraint(equalTo: poarentView.bottomAnchor, constant : -(poarentView.bounds.height/2)).isActive = true
        textBox.textContainer.size = textBox.bounds.size
        poarentView.addSubview(dropDown)
        dropDown.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dropDown.topAnchor.constraint(equalTo: changFontStackView.topAnchor).isActive = true
        dropDown.leftAnchor.constraint(equalTo: poarentView.leftAnchor, constant: 8).isActive = true
        dropDown.rightAnchor.constraint(equalTo: changFontStackView.leftAnchor, constant: -4).isActive = true
        dropDown.bottomAnchor.constraint(lessThanOrEqualTo: changFontStackView.bottomAnchor).isActive = true
        btnItalic.titleLabel?.font = UIFont.italicSystemFont(ofSize: 14)
        btnItalic.imageView?.image = UIImage.init(named: "radio_unselected")?.withRenderingMode(.alwaysTemplate)
        btnItalic.tintColor = UIColor.darkGray
        btnBold.imageView?.image = UIImage.init(named: "radio_unselected")?.withRenderingMode(.alwaysTemplate
        )
        btnBold.tintColor = UIColor.darkGray
        // ADD INSERT IMAGE BUTTON
        poarentView.addSubview(insertImageButton)
        insertImageButton.topAnchor.constraint(equalTo: changFontStackView.topAnchor).isActive = true
        insertImageButton.rightAnchor.constraint(equalTo: poarentView.rightAnchor, constant: -12).isActive = true
        insertImageButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        insertImageButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        insertImageButton.addTarget(self, action: #selector(insertImage), for: .touchUpInside)
        textBox.delegate = self
    }
    
    //MARK : - OPENS LIBRARY TO BROWSE PHOTOS
    @objc func insertImage(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

    
    //MARK :- Bold Radio Button clicked
    @IBAction func makeTextBold(_ sender: Any) {
        isBoldSelected = !isBoldSelected
        isItalicSelected = false
        if isBoldSelected{
            btnBold.setImage(UIImage.init(named: "radio_selected")?.withRenderingMode(.alwaysTemplate
                ), for: .normal)
        }
        else{
            btnBold.setImage(UIImage.init(named: "radio_unselected")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        changeFont()
    }
    
    
    //MARK :- Italic Radio Button clicked
    @IBAction func makeTextItalic(_ sender: Any) {
        isItalicSelected = !isItalicSelected
        isBoldSelected = false
        if isItalicSelected{
            btnItalic.setImage(UIImage.init(named: "radio_selected")?.withRenderingMode(.alwaysTemplate
                ), for: .normal)
            
            
        }
        else{
            btnItalic.setImage(UIImage.init(named: "radio_unselected")?.withRenderingMode(.alwaysTemplate), for: .normal)
            
        }
        changeFont()
    }
    
    //MARK : - Change Font Style to Bold/Italic
    func changeFont(){
        if isBoldSelected{
            btnItalic.setImage(UIImage.init(named: "radio_unselected")?.withRenderingMode(.alwaysTemplate), for: .normal)
            textBox.font = UIFont.boldSystemFont(ofSize: 15)
        }
        else if isItalicSelected{
            btnBold.setImage(UIImage.init(named: "radio_unselected")?.withRenderingMode(.alwaysTemplate), for: .normal)
            textBox.font = UIFont.italicSystemFont(ofSize: 15)
        }
    }
    //MARK : - Add a Done Button on the top of Keyboard
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        textBox.inputAccessoryView = doneToolbar
    }
    
    //MARK : - DOne Button on the Keyboard clicked to hide keyboard
    @objc  func doneButtonAction(){
        textBox.resignFirstResponder()
    }
    
    // MARK : - Returns Attributed string of text view text
    func getAttributedText(completionHandler : (NSMutableAttributedString)->()){
        
        var enteredString = NSMutableAttributedString(attributedString: textBox.attributedText)
        var length = 0
        if enteredString.length > 0{
            length = 1
        }
        else{
            completionHandler(enteredString)
        }
        textBox.attributedText.enumerateAttributes(in: NSRange(location: 0, length: length), options: .longestEffectiveRangeNotRequired) { (attributes, range, stop) in
            enteredString = NSMutableAttributedString(attributedString: textBox.attributedText)
            enteredString.addAttributes(attributes, range: range)
            completionHandler(enteredString)
        }
    }
    
    
    //MARK :- Insert Image in Text
    func attchImageToText(withImage : UIImage){
        getAttributedText(){ enteredString in
            let imageAttachment = NSTextAttachment()
            imageAttachment.bounds = CGRect.init(x: 0, y: 0, width: 48, height: 48)
            imageAttachment.image = withImage
            //MAKE NS ATTRIBUTED STRING
            let imageString = NSAttributedString(attachment: imageAttachment)
            enteredString.append(imageString)
            textBox.attributedText = enteredString
        }
    }
}

extension  ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //GET SELECTED IMAGE HERE
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // GOT THE IMAGE HERE INSERT IN TO TEXT BOX
            attchImageToText(withImage: pickedImage)
            dismiss(animated: true, completion: nil)
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //USER CANCELLED PICKIN G UP THE IMAGE
        dismiss(animated: true, completion: nil)
    }
}


extension ViewController : InformSuperController{
    func sendMessage(action: String) {
        print(action)
        switch action {
        case "disbletextbox":
            textBox.isUserInteractionEnabled = false
        case "enabletextbox":
            textBox.isUserInteractionEnabled = true
        default:
            //here font is coming but the parameter name is action, little confusing though
            dropDown.titleLabel?.text = action
            textBox.font = UIFont.init(name: action, size: 15)
            textBox.isUserInteractionEnabled = true
        }
    }
}

extension ViewController : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        getAttributedText(){ attributedText in
            textView.attributedText = attributedText
        }
    }
}
