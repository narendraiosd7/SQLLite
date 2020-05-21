//
//  ContactTextField.swift
//  sqliteA
//
//  Created by Vadde Narendra on 12/22/19.
//  Copyright © 2019 Varalakshmi Kacherla. All rights reserved.
//

import UIKit

@IBDesignable
class ContactTextField: UITextField
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor(white: 230 / 255, alpha: 1).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        return bounds.insetBy(dx: 8, dy: 7)

    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        return textRect(forBounds: bounds)

    }
    
}
