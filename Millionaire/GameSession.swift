//
//  GameSession.swift
//  Millionaire
//
//  Created by Kirill on 17.08.2022.
//

import Foundation

class GameSession: Codable {

    var totalQuestions: Int
    var answeredСorrectly: Int
    
    init(totalQuestions: Int, answeredCorrectly: Int) {
        self.totalQuestions = totalQuestions
        self.answeredСorrectly = answeredCorrectly
    }
}
