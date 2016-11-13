//
//  TRCardsViewController
//  Tinder
//
//  Created by parry on 11/12/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TRCardsViewController: UIViewController {
    
    var tRDraggableImageViewOriginalCenter: CGPoint!
    @IBOutlet weak var tRDraggableImageView: TRDraggableImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        tRDraggableImageView.profilePhotoImageView.image = #imageLiteral(resourceName: "ryan")

    }



}

