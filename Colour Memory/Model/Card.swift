//
//  Card.swift
//  Colour Memory
//
//  Created by Alex Fung on 20/6/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class Card {
    var colour:Int
    var shown = false
    var image : UIImage
    init(_ colour : Int){
        self.colour = colour
        self.image = UIImage(named: "colour\(colour)")!
    }
    
    func sameColour(_ card:Card) -> Bool {
        return card.colour == self.colour
    }
}
