//
//  AlertHelper.swift
//  SecretMessage
//
//  Created by Elano on 08/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class AlertHelper: NSObject {

    static func showSimpleAlert(_ controller: UIViewController?, title: String? = nil, message: String, closure: @escaping () -> Void = { })
    {
        ThreadHelper.main {
            let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                closure()
            }))
            
            present(controller: controller, alert: refreshAlert)
        } 
    }
    
    private static func present(controller: UIViewController?, alert: UIAlertController)
    {
        controller?.present(alert, animated: true, completion: nil)
    }
}
