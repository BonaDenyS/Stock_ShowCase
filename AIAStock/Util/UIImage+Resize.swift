//
//  UIImage+Resize.swift
//  FiillerAraniyor
//
//  Created by Bona Deny S on 25/02/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

extension UIImage{
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
