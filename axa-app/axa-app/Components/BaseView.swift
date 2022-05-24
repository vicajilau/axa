//
//  BaseView.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 24/4/22.
//

import UIKit

class BaseView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
    }
    
    /// Use a horizontal slide transition to display a new BaseView. It has no effect if the view controller is already on the stack.
    func pushView(nextView: BaseView, animated: Bool = true) {
        navigationController?.pushViewController(nextView, animated: animated)
    }
    
    /// Returns the popped BaseView.
    func popView(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

}

// MARK: - Hide Keyboard
extension BaseView {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
