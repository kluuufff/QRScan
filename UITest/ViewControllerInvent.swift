//
//  ViewControllerInvent.swift
//  UITest
//
//  Created by iHope on 06.03.2018.
//  Copyright © 2018 iHope. All rights reserved.
//

import UIKit

class ViewControllerInvent: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //@IBOutlet weak var pickView: UIPickerView!
    @IBOutlet weak var pickResult: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var productPic: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    let choice = ["Отличный", "Нормальный", "Плохой"]
    
    // variables to gold current data
    var picker : UIPickerView!
    var activeTextField = 0
    var activeTF : UITextField!
    var activeValue = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return choice.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return choice[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickResult.text = choice[row]
    }
    
    // start editing text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // set up correct active textField (no)
        activeTextField = 0
        
        // set active Text Field
        activeTF = textField
        
        self.pickUpValue(textField: textField)
        
    }
    
    func pickUpValue(textField: UITextField) {
        
        // create frame and size of picker view
        picker = UIPickerView(frame:CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 216)))
        
        // deletates
        picker.delegate = self
        picker.dataSource = self
        
        // if there is a value in current text field, try to find it existing list
        if textField.text != nil {
            var row : Int?
            
            // look in correct array
            row = nil
            
            // we got it, let's set select it
            if row != nil {
                picker.selectRow(row!, inComponent: 0, animated: true)
            }
        }
        
        picker.backgroundColor = UIColor.white
        textField.inputView = self.picker
        
        // toolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.white
        toolBar.sizeToFit()
        
        // buttons for toolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // done
    
    var temp = String()
    
    @objc func doneClick() {
        activeTF.resignFirstResponder()
        temp = activeTF.text!
    }
    
    // cancel
    @objc func cancelClick() {
        activeTF.text = temp
        activeTF.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegates for text fields
        pickResult.delegate = self
        
        //border for textView
        let myColor : UIColor = UIColor( red: 204.0/255.0, green: 204.0/255.0, blue:204.0/255.0, alpha: 1.0 )
        textView!.layer.borderWidth = 0.7
        textView!.layer.borderColor = myColor.cgColor
        textView!.layer.cornerRadius = 7
        
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            productPic.contentMode = .scaleToFill
            productPic.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addData(_ sender: Any) {
        let myTVC = storyboard?.instantiateViewController(withIdentifier: "ViewControllerTableView") as! ViewControllerTableView
        navigationController?.pushViewController(myTVC, animated: true)
    }
    
}
