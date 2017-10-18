//
//  Alerta.swift
//  Carros
//
//  Created by André Brilho on 26/11/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import Foundation
import UIKit

class Alerta {

    class func alerta(msg: String, viewController: UIViewController){
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    
    
    
    }
    
    
    class func alerta(msg: String, viewController: UIViewController, action :((UIAlertAction!) -> Void)!){
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: action))
        viewController.presentViewController(alert, animated: true, completion: nil)
        
        
        
    }
    
}
