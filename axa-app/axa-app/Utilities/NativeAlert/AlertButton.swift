//
//  ButtonAlert.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 8/5/22.
//

import UIKit

class AlertButton {
    
    let title: String
    let style: UIAlertAction.Style
    let onPressed: ((UIAlertAction) -> Void)?
    
    /**
     Creates a abstraction for the creation of buttons of a native alert.

     - Parameter title: The button title displayed in this button.
     - Parameter style: The button style. By default is `default`.
     - Parameter onPressed: The function that will be triggered when this button is pressed. By default this is nil.
     */
    init(title: String, style: UIAlertAction.Style = .default, onPressed: ((UIAlertAction) -> Void)? = nil ) {
        self.title = title
        self.style = style
        self.onPressed = onPressed
    }
}
