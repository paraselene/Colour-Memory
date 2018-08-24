//
//  ColourMemoryHighScoreViewController.swift
//  Colour Memory
//
//  Created by Alex Fung on 20/6/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class ColourMemoryHighScoreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Highscores.shared.getHighscores().count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let highscore = Highscores.shared.getHighscores()
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScore", for: indexPath) as! ColourMemoryHighScoreTableViewCell
        
        cell.rankLabel?.text = indexPath.row > 0 ? "\(indexPath.row)" : "Rank"
        cell.nameLabel?.text = indexPath.row > 0 ? "\(highscore[indexPath.row-1]["name"]!)" : "Name"
        cell.scoreLabel?.text = indexPath.row > 0 ? "\(highscore[indexPath.row-1]["score"]!)" : "Score"
        return cell
    }
    
    @IBAction func close(_ sender: Any) {
        self .dismiss(animated: true) {
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
