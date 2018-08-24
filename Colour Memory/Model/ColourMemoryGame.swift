//
//  ColourMemoryGameController.swift
//  Colour Memory
//
//  Created by Alex Fung on 20/6/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
import Foundation

protocol ColourMemoryGameDelegate {
    func colourMemoryGameDidStart(game: ColourMemoryGame)
    func colourMemoryGameDidEnd(game: ColourMemoryGame)
    func colourMemoryGame(game: ColourMemoryGame, freezed freeze:Bool)
    func colourMemoryGame(game: ColourMemoryGame, flipCards cards: [Card])
    func colourMemoryGame(game: ColourMemoryGame, hideCards cards: [Card])
    func colourMemoryGame(game: ColourMemoryGame, updateScore score: Int)
}

class ColourMemoryGame{
    
    var cards = [Card]()
    
    var removedCards = [Card]()
    
    var selectedCard : Card?
    
    var delegate: ColourMemoryGameDelegate?
    
    var score = 0
    
    init(){
        for index in 1...8{
            cards.append(Card(index))
            cards.append(Card(index))
        }
        cards.shuffle()
        self.delegate?.colourMemoryGameDidStart(game: self)
    }
    
    func reset(){
        cards.shuffle()
        removedCards.removeAll()
        selectedCard = nil
        score = 0
        self.delegate?.colourMemoryGame(game: self, updateScore: 0)
        self.delegate?.colourMemoryGameDidStart(game: self)
    }
    
    func didSelectCard(_ card:Card){
        if self.selectedCard === card{
            //select the same card
            return
        }
        
        self.delegate?.colourMemoryGame(game: self, flipCards: [card])
        
        if let selectedCard = selectedCard{
            self.delegate?.colourMemoryGame(game: self, freezed: true)
            self.score += card.sameColour(selectedCard) ? 2 : -1
            self.delegate?.colourMemoryGame(game: self, updateScore: self.score)
            if card.sameColour(selectedCard){
                removedCards.append(card)
                removedCards.append(selectedCard)
                if (removedCards.count == cards.count){
                    self.delegate?.colourMemoryGameDidEnd(game: self)
                    return
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if card.sameColour(self.selectedCard!){
                    self.delegate?.colourMemoryGame(game: self, hideCards: [card,self.selectedCard!])
                }else{
                    self.delegate?.colourMemoryGame(game: self, flipCards: [card,self.selectedCard!])
                }
                
                self.delegate?.colourMemoryGame(game: self, freezed: false)
                self.selectedCard = nil
            }
        }else{
            selectedCard = card
        }
    }
}
