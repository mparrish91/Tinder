//
//  TRDraggableImageView.swift
//  Tinder
//
//  Created by parry on 11/12/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TRDraggableImageView: UIView {
    
    var profiePhotoImageViewOriginalCenter: CGPoint!

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet var contentView: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "TRDraggableImageView", bundle: nil).instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        }
    
    @IBAction func onPan(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.location(in: self)
        let xTranslation = panGestureRecognizer.translation(in: self).x
        var velocity : CGPoint = panGestureRecognizer.velocity(in: self)
        let angle  = xTranslation.degreesToRadians
        switch panGestureRecognizer.state {
            
        case .began:
            
            if point.y > self.frame.height/2
            {
//                profiePhotoImageViewOriginalCenter = profilePhotoImageView.center
                print("point is in lower half")

            }
        case .changed:
            if velocity.x > 0
            {
                profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
                profilePhotoImageView.center = CGPoint(x: profiePhotoImageViewOriginalCenter.x + xTranslation, y: profiePhotoImageViewOriginalCenter.y)

            }
            else
            {
                profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
                profilePhotoImageView.center = CGPoint(x: profiePhotoImageViewOriginalCenter.x + xTranslation, y: profiePhotoImageViewOriginalCenter.y)

            }

            
        case.ended:
            profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0.degreesToRadians))
            profilePhotoImageView.center = profiePhotoImageViewOriginalCenter

            
        default:
            return
            
        }
    }



}



extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
