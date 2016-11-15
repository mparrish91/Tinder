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
    private var lastTranslation: CGPoint!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
        layer.cornerRadius = 120
//        layer.masksToBounds = true

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
//        let point = panGestureRecognizer.location(in: self)
//        var xTranslation = panGestureRecognizer.translation(in: self).x
//        var velocity : CGPoint = panGestureRecognizer.velocity(in: self)
//        let angle  = xTranslation.degreesToRadians
//        let reverseAngle  = xTranslation.degreesToRadians * -1
//
//        switch panGestureRecognizer.state {
//            
//        case .began:
//            
//            profiePhotoImageViewOriginalCenter = profilePhotoImageView.center
//
//            
//          
//        case .changed:
//            
//            if point.y > self.frame.height/2
//            {
//                print("point is in lower half")
//                
//                
//                if velocity.x > 0
//                {
//                    profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(reverseAngle))
//                    profilePhotoImageView.center = CGPoint(x: profiePhotoImageViewOriginalCenter.x + xTranslation, y: profiePhotoImageViewOriginalCenter.y)
//                    
//                }
//                else
//                {
//                    profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(reverseAngle))
//                    profilePhotoImageView.center = CGPoint(x: profiePhotoImageViewOriginalCenter.x + xTranslation, y: profiePhotoImageViewOriginalCenter.y)
//                    
//                }
//            }
//            else
//            {
//                print("point is in upper half")
//                
//                
//                if velocity.x > 0
//                {
//                    profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
//                    profilePhotoImageView.center = CGPoint(x: profiePhotoImageViewOriginalCenter.x + xTranslation, y: profiePhotoImageViewOriginalCenter.y)
//                    
//                }
//                else
//                {
//                    profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
//                    profilePhotoImageView.center = CGPoint(x: profiePhotoImageViewOriginalCenter.x + xTranslation, y: profiePhotoImageViewOriginalCenter.y)
//                    
//                }
//
//            }
//            
//            
//        case.ended:
//            profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0.degreesToRadians))
//            profilePhotoImageView.center = profiePhotoImageViewOriginalCenter
//
//            if xTranslation > 50
//            {
//                UIView.animate(withDuration: 1.0, animations: {
//                    self.profilePhotoImageView.center = CGPoint(x: self.contentView.frame.width * 1.5, y: self.profiePhotoImageViewOriginalCenter.y)
//                })
//            }
//            else if xTranslation < -50{
//                UIView.animate(withDuration: 1.0, animations: {
//                    self.profilePhotoImageView.center = CGPoint(x: -1 * (self.contentView.frame.width * 1.5), y: self.profiePhotoImageViewOriginalCenter.y)
//                })
//            }
//            
//
//            
//        default:
//            return
//            
//        }
//    }
    
        let translation = panGestureRecognizer.translation(in: contentView)
        let location = panGestureRecognizer.location(in: contentView)
        
        // Test to see if the location is top or bottom half
        let topHalf = CGRect(x: profilePhotoImageView.frame.origin.x, y: profilePhotoImageView.frame.origin.y, width: profilePhotoImageView.frame.width, height: profilePhotoImageView.frame.height / 2)
        let bottomHalf = CGRect(x: profilePhotoImageView.frame.origin.x, y: topHalf.maxY, width: profilePhotoImageView.frame.width, height: profilePhotoImageView.frame.height / 2)
        // If bottom half, rotate opposite
        let rotationDirection = bottomHalf.contains(location) ? CGFloat(-1) : CGFloat(1)
        let angle  = translation.x.degreesToRadians

        
        if panGestureRecognizer.state == .began {
            profiePhotoImageViewOriginalCenter = profilePhotoImageView.center
            lastTranslation = translation
        } else if panGestureRecognizer.state == .changed {
            // Move Y
            profilePhotoImageView.center = CGPoint(x: profiePhotoImageViewOriginalCenter.x + translation.x , y: profiePhotoImageViewOriginalCenter.y)
            
            // Rotate
            let rotation = rotationDirection * (translation.x - lastTranslation.x).degreesToRadians
//            profilePhotoImageView.transform = profilePhotoImageView.transform.rotated(by: rotation)
            profilePhotoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))

            lastTranslation = translation
            
        } else if panGestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.25, animations: {
                if translation.x > 50 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.profilePhotoImageView.center = CGPoint(x: self.contentView.frame.width * 2, y: self.profilePhotoImageView.center.y)
                    })
                } else if translation.x < -50 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.profilePhotoImageView.center = CGPoint(x: -self.contentView.frame.width * 2, y: self.profilePhotoImageView.center.y)
                    })
                } else {
                    // Return to center
                    self.profilePhotoImageView.center = self.profiePhotoImageViewOriginalCenter
                    // Reset transfrom (to original)
                    self.profilePhotoImageView.transform = CGAffineTransform.identity
                }
            })
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
