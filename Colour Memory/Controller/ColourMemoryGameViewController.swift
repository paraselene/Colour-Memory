//
//  ViewController.swift
//  Colour Memory
//
//  Created by Alex Fung on 20/6/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
import Foundation

class ColourMemoryGameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ColourMemoryGameDelegate {
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    @IBOutlet var scoreLabel: UILabel!
    
    let game = ColourMemoryGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.game.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : forcePortrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait
    }
    
    // MARK: ColourMemoryGameDelegate
    func colourMemoryGameDidStart(game: ColourMemoryGame) {
        self.cardCollectionView.reloadData()
        self.cardCollectionView.isUserInteractionEnabled = true
    }
    
    func colourMemoryGameDidEnd(game: ColourMemoryGame) {
        var observer : Any?
        let alert = UIAlertController(title: "Please enter your name", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            let rank = Highscores.shared.saveHighscore(name: (alert.textFields?[0].text)!, score: game.score)
            
            let alert2 = UIAlertController(title: rank > 0 ? "You are Rank \(rank) with \(game.score) marks" : "You score \(game.score) marks only. Try harder please :)", message: "", preferredStyle: .alert)
                alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.performSegue(withIdentifier: "HighScores", sender: self)
            }))
            self.present(alert2, animated: true, completion: {
            })
            game.reset()
            if let observer = observer{
                    NotificationCenter.default.removeObserver(observer)
            }
            
        })
        alert.addAction(alertAction)
        alertAction.isEnabled = false
        alert.addTextField { (textfield) in
        }
        
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object:alert.textFields?[0],
                                               queue: OperationQueue.main) { (notification) -> Void in
                                                                alertAction.isEnabled = !(alert.textFields?[0].text?.isEmpty)!
        }
        self.present(alert, animated: true) {
            
        }
    }
    
    
    func colourMemoryGame(game: ColourMemoryGame, freezed freeze: Bool) {
        self.cardCollectionView.isUserInteractionEnabled = !freeze
    }
    
    func colourMemoryGame(game: ColourMemoryGame, flipCards cards: [Card]) {
        for card in cards{
            for index in 0..<game.cards.count{
                let cell = cardCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! ColourMemoryCollectionViewCell
                if cell.card === card{
                    cell.flipCard()
                    break
                }
            }
        }
    }
    
    func colourMemoryGame(game: ColourMemoryGame, hideCards cards: [Card]) {
        for card in cards{
            for index in 0..<game.cards.count{
                let cell = cardCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! ColourMemoryCollectionViewCell
                if cell.card === card{
                    cell.removeCard()
                    break
                }
            }
        }
    }
    
    
    func colourMemoryGame(game: ColourMemoryGame, updateScore score: Int) {
        self.scoreLabel.text = "Score: \(score)"
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        let collectionViewSize = collectionView.frame.size
        let cardSize = CGSize(width: 152, height: 190)
        let widthRatio = (collectionViewSize.width - 50) / cardSize.width / 4
        let heightRatio = (collectionViewSize.height - 50) / cardSize.height / 4
        return widthRatio < heightRatio ? CGSize(width: widthRatio * cardSize.width, height: widthRatio * cardSize.height) : CGSize(width: heightRatio * cardSize.width, height: heightRatio * cardSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let collectionViewSize = collectionView.frame.size
        let cardSize = CGSize(width: 152, height: 190)
        let widthRatio = (collectionViewSize.width - 50) / cardSize.width / 4
        let heightRatio = (collectionViewSize.height - 50) / cardSize.height / 4
        return widthRatio < heightRatio ? (collectionViewSize.height - 20 - cardSize.height * widthRatio * 4) / 3 : (collectionViewSize.height - 20 - cardSize.height * heightRatio * 4) / 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let collectionViewSize = collectionView.frame.size
        let cardSize = CGSize(width: 152, height: 190)
        let widthRatio = (collectionViewSize.width - 50) / cardSize.width / 4
        let heightRatio = (collectionViewSize.height - 50) / cardSize.height / 4
        return widthRatio < heightRatio ? (collectionViewSize.width - 20 - cardSize.width * widthRatio * 4) / 3 : (collectionViewSize.width - 20 - cardSize.width * heightRatio * 4) / 3
    }
    
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as! ColourMemoryCollectionViewCell
        cell.card = game.cards[indexPath.row]
        cell.resetCard()
        return cell
    }
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ColourMemoryCollectionViewCell
        game.didSelectCard(cell.card!)
        collectionView.deselectItem(at: indexPath, animated:true)
    }
}

