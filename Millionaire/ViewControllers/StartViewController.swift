//
//  ViewController.swift
//  Millionaire
//
//  Created by Kirill on 05.08.2022.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        let vc = GameViewController()
        vc.delegate = self
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
    }
    
}

extension StartViewController: GameViewControllerDelegate {
    func didEndGame(withResult result: GameSession) {
        print(result.answeredСorrectly)
    }
}


