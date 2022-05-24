//
//  Alerts.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 8/5/22.
//

import UIKit

/**
 This class is an abstraction of native alerts
 */
class NativeAlert {
    
    private let alert: UIAlertController
    private let view: UIViewController
    
    /**
     Simplifies the creation of a native alert by simply instantiating this object and calling its `show()` function

     - Parameter view: The view on which the alert will be displayed.
     - Parameter title: The alert title displayed at the top.
     - Parameter body: The body of the alert message.
     - Parameter style: The alert style. By default is `.alert`
     - Parameter buttons: An array of `AlertButton` that will be displayed in the alert. It cant be empty.
     - Important: `buttons` param in the constructor cannot be empty.
     - Postcondition: After building the alert, the `show()` function must be called to display it.

     - Returns: A new `Alert` it can be displayed by `show()` method.
     */
    init(view: UIViewController, title: String, body: String, style: UIAlertController.Style = .alert, buttons: [AlertButton]) {
        self.view = view
        alert = UIAlertController(title: title, message: body, preferredStyle: style)
        addButtonsIntoTheAlert(buttons: buttons)
    }
    
    /**
     Simplify the creation of a native alert that only has a single button, by instantiating this object and calling its `show()` function
     
     ```
     NativeAlert(view: self, title: "ERROR", body: "Something unexpected happened", primaryButton: AlertButton(title: "ACCEPT")).show()
     ```
     
     - Parameter view: The view on which the alert will be displayed.
     - Parameter title: The alert title displayed at the top.
     - Parameter body: The body of the alert message.
     - Parameter style: The alert style. By default is `.alert`
     - Parameter button: The only `AlertButton` that will be displayed in the alert. It cant be empty.
     - Postcondition: After building the alert, the `show()` function must be called to display it.

     - Returns: A new `Alert` it can be displayed by `show()` method.
     */

    convenience init(view: UIViewController, title: String, body: String, style: UIAlertController.Style = .alert, button: AlertButton) {
        self.init(view: view, title: title, body: body, buttons: [button])
    }
    
    private func addButtonsIntoTheAlert(buttons: [AlertButton]) {
        if buttons.isEmpty {
            Utils.controlledFailure(message: "You cannot create an alert without any buttons")
        }
        for button in buttons {
            alert.addAction(UIAlertAction(title: button.title, style: button.style, handler: button.onPressed))
        }
    }
    
    /// Presents a view controller modally with animation.
    /// - Parameter onCompleted: The block to execute after the presentation finishes. This block has no return value and takes no parameters. By default is nil.
    /// - Parameter animated: If you want the presentation to be animated or not. By default is true.
    func show(animated: Bool = true, onCompleted: (() -> Void)? = nil) {
        view.present(alert, animated: animated, completion: onCompleted)
    }
    
}
