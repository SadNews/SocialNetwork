//
//  ErrorReporting.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 24.09.2020.
//

import UIKit

class ErrorReporting {

    static func showMessage(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
