//
//  DesignableView.swift
//  iWeather
//
//  Created by SENTIENTGEEKS on 13/12/23.
//

import UIKit
@IBDesignable
class DesignableView: UIView {
}
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
