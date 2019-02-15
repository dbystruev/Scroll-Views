//
//  ViewController.swift
//  Scroll Views
//
//  Created by Denis Bystruev on 15/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    @IBAction func editingDidEnd(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - ... Keyboard
extension ViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        switch notification.name {
        case UIResponder.keyboardDidShowNotification:
            guard let value = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
                return
            }
            let keyboardFrame = value.cgRectValue
            let keyboardSize = keyboardFrame.size
            
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
        case UIResponder.keyboardWillHideNotification:
            scrollView.contentInset = UIEdgeInsets.zero
            scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
            
        default:
            break
        }
    }
}

