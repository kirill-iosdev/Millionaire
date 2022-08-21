//
//  GameViewControllerDelegate.swift
//  Millionaire
//
//  Created by Kirill on 20.08.2022.
//

import Foundation

protocol GameViewControllerDelegate: AnyObject {
    func didEndGame(withResult result: GameSession)
}
