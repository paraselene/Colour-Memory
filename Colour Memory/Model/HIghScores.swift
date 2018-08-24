//
//  HIghScores.swift
//  Colour Memory
//
//  Created by Alex Fung on 20/6/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

class Highscores {
    static let shared = Highscores()
    
    func getHighscores() -> [[String:Any]] {
        return UserDefaults.standard.array(forKey: "HighScores") as? [[String:Any]] ?? []
    }
    
    func saveHighscore(name: String, score: Int) -> Int{
        var rank = 0
        let entry = ["name": name, "score": score] as [String : Any]
        
        var scores:[Dictionary<String,Any>]  = getHighscores()
        scores.append(entry)
        
        scores = scores.sorted{return $0["score"] as! Int > $1["score"] as! Int}
        if scores.count > 20 {
            scores.removeLast()
        }
        
        if let index = scores.index(where:{ target -> Bool in
            let targetName : String = target["name"] as! String
            let targetScore : Int = target["score"] as! Int
            return targetName == name && targetScore == score
        }){
            rank = index + 1
        }
        
        UserDefaults.standard.set(scores, forKey: "HighScores")
        return rank
    }
}

