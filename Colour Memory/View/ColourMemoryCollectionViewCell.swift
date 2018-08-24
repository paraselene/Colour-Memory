//
//  ColourMemoryCollectionViewCell.swift
//  Colour Memory
//
//  Created by Alex Fung on 20/6/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class ColourMemoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var colourImageView: UIImageView!
    
    var shown = false
    
    var card:Card?{
        didSet{
            guard let card = card else { return }
            colourImageView.image = card.image
        }
    }
    
    func flipCard() {
        shown = !shown
        if shown {
            UIView.transition(from: bgImageView,
                              to: colourImageView,
                                      duration: 0.5,
                                      options: [.transitionFlipFromRight, .showHideTransitionViews],
                                      completion: { (finished: Bool) -> () in
                                        
            })
        } else {
            UIView.transition(from: colourImageView,
                              to: bgImageView,
                                      duration: 0.5,
                                      options: [.transitionFlipFromRight, .showHideTransitionViews],
                                      completion:  { (finished: Bool) -> () in
            })
        }
    }
    
    func resetCard(){
        self.alpha = 1
        self.shown = false
        self.bgImageView.isHidden = false
        self.colourImageView.isHidden = true
        self.isHidden = false
    }
    
    func removeCard(){
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (finished: Bool) in
            self.isHidden = true
        }
    }
    
}
