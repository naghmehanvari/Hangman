//
//  Hearts.swift
//  Hangman
//
//  Created by Naghmeh on 10/27/16.
//  Copyright © 2016 Naghmeh. All rights reserved.
//

import UIKit

class Hearts: UIView {

    var listOfHearts = [UIImageView]()
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var leftCorner = 0
        for _ in 0...9
        {
            let imageName = "2764.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: leftCorner, y: 0, width: 25, height: 25)
            leftCorner += 35
            print(leftCorner)
            listOfHearts.append(imageView)
            addSubview(imageView)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
