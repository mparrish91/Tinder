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

        switch panGestureRecognizer.state {
            
        case .began:
            profiePhotoImageViewOriginalCenter = profilePhotoImageView.center
        case .changed:
            profilePhotoImageView.center = CGPoint(x: profiePhotoImageViewOriginalCenter.x + xTranslation, y: profiePhotoImageViewOriginalCenter.y)
            
        case.ended: break
            
        default:
            return
            
        }
    }


}
