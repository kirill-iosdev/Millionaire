//
//  GameViewController.swift
//  Millionaire
//
//  Created by Kirill on 05.08.2022.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var gameProgressLabel: UILabel!
    @IBOutlet weak var winAmountLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var fiftyButton: UIButton!
    @IBOutlet weak var audienceButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    @IBOutlet weak var afterAnswerView: UIView!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: GameViewControllerDelegate?
    private var questions = Game.shared.questions
    private var answeredQuestions = 0
    private var currentQuestion = 0
    private let winArray = ["0", "100", "500", "1 000", "5 000", "10 000", "50 000", "100 000","250 000","500 000","1 000 000"]
    private var gameSession = GameSession(totalQuestions: Game.shared.questions.count, answeredCorrectly: 0)
    var record: GameSession?
    var hintButtons: [UIButton] {
        [fiftyButton, audienceButton, callButton]
    }
    
    var answerButtons: [UIButton] {
        [answerAButton, answerBButton, answerCButton, answerDButton]
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Game.shared.gameSession = gameSession
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        afterAnswerView.isHidden = true
        showNextQuestion(answeredQuestions: 0)
        answeredQuestions = 0
        setTags()
    }
    
    //MARK: - Button Action
    
    @IBAction private func answerButtonsPressed(_ sender: UIButton) {
        if sender.tag == questions[currentQuestion].correctAnswer {
            nextQuestion(answeredQuestions: answeredQuestions, tag: sender.tag)
        } else {
            showIncorrectAlert()
            gameSession = GameSession(totalQuestions: questions.count, answeredCorrectly: answeredQuestions)
            Game.shared.addRecord(gameSession)
            self.delegate?.didEndGame(withResult: gameSession)
            print(Game.shared.records)
        }
    }
    
    @IBAction private func nextButton(_ sender: UIButton) {
        if (nextButton.currentTitle!) == "Продолжить" {
            afterAnswerView.isHidden = true
            self.answeredQuestions += 1
            questions.remove(at: self.currentQuestion)
            self.showNextQuestion(answeredQuestions: self.answeredQuestions)
        } else if (nextButton.currentTitle == "OK") {
            afterAnswerView.isHidden = true
        } else {
            self.answeredQuestions = 0
            self.showNextQuestion(answeredQuestions: 0)
            afterAnswerView.isHidden = true
        }
        unblockButtons()
    }

    //MARK: - Methods
    
    private func setTags() {
        answerAButton.tag = 0
        answerBButton.tag = 1
        answerCButton.tag = 2
        answerDButton.tag = 3
    }
    
    private func showNextQuestion(answeredQuestions: Int) {
        gameProgressLabel.text = "Вопрос " + "\(answeredQuestions + 1)" + " из 10"
        winAmountLabel.text = "Выигрыш: " + winArray[answeredQuestions] + "₴"
        let index = Int(arc4random_uniform(UInt32(questions.count - 1)))
        self.currentQuestion = index
        self.answerAButton.setTitle(self.questions[index].answerA, for: .normal)
        self.answerBButton.setTitle(self.questions[index].answerB, for: .normal)
        self.answerCButton.setTitle(self.questions[index].answerC, for: .normal)
        self.answerDButton.setTitle(self.questions[index].answerD, for: .normal)
        questionTextLabel.text = questions[index].text
    }
    
    private func blockButtons () {
        let allButtons = answerButtons + hintButtons
        
        for button in allButtons {
            button.isEnabled = false
        }
    }
    
    private func unblockButtons () {
        for button in answerButtons {
            button.isEnabled = true
        }
    }
    
    private func nextQuestion(answeredQuestions: Int, tag: Int) {
        afterAnswerView.isHidden = false
        if answeredQuestions == 9 {
            correctLabel.text = "Победа!"
            self.nextButton.setTitle("OK", for: .normal)
            hintLabel.text = "Вы - Миллионер!"
            gameSession = GameSession(totalQuestions: questions.count, answeredCorrectly: answeredQuestions + 1)
            Game.shared.addRecord(gameSession)
        } else {
            correctLabel.text = "Правильно!"
            self.nextButton.setTitle("Продолжить", for: .normal)
            hintLabel.text = "Ваш выигрыш \(winArray[answeredQuestions + 1] + "₴")"
        }
        
        for button in answerButtons {
            if button.tag == tag {
                self.blockButtons()
            }
        }
    }
    
    private func showIncorrectAlert() {
        afterAnswerView.isHidden = false
        correctLabel.text = "Неправильно!"
        let correctAnswerText: String
        
        switch  questions[currentQuestion].correctAnswer {
            case 0:
                correctAnswerText = questions[currentQuestion].answerA
            case 1:
                correctAnswerText = questions[currentQuestion].answerB
            case 2:
                correctAnswerText = questions[currentQuestion].answerC
            default:
                correctAnswerText = questions[currentQuestion].answerD
        }
        
        hintLabel.text = "Правильный ответ: " + correctAnswerText
        self.nextButton.setTitle("Начать сначала", for: .normal)
        self.questions = Game.shared.questions
        blockButtons()
    }
}
