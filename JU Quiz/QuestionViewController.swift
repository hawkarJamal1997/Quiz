//
//  QuestionViewController.swift
//  JU Quiz
//
//  Created by Hawkar Jamal Ali on 2020-10-29.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var questionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonAnswerA: UIButton!
    @IBOutlet weak var buttonAnswerB: UIButton!
    @IBOutlet weak var buttonAnswerC: UIButton!
    @IBOutlet weak var buttonAnswerD: UIButton!
    
    private var haveWon = false
    
    var questions: [Question] = [] {
        didSet {
            question = questions.removeFirst()
        }
    }
    var question: Question?
    var numberOfQuestions = 0
    var rightAnswers = 0
    var categories = [String]()
    var difficulty = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionView.layer.contents = #imageLiteral(resourceName: "appBackground.png" ).cgImage
        questionLabel.layer.cornerRadius = 20
        questionLabel.layer.masksToBounds = true
        
        var buttons = [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD]
        buttons.forEach { (button) in
            button?.layer.cornerRadius = 10
            button?.layer.shadowOpacity = 0.7
            button?.layer.shadowOffset = CGSize(width: 4, height: 4)
            button?.layer.shadowRadius = 15.0
            button?.layer.shadowColor = UIColor.darkGray.cgColor
        }
        
        questionLabel.text = question?.question
        buttons.shuffle()
        let correctButton = buttons.removeFirst()
        correctButton?.setTitle(question?.correctAnswer, for: .normal)
        
        question?.incorrectAnswers.forEach({ (answer) in
            let button = buttons.removeFirst()
            button?.setTitle(answer, for: .normal)
            
        })
    }
    
    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        buttonAnswerA.title(for: .normal) == question?.correctAnswer ? showRightAnswerAlert(button: buttonAnswerA) : showWrongAnswerAlert(button: buttonAnswerA)
    }
    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        buttonAnswerB.title(for: .normal) == question?.correctAnswer ? showRightAnswerAlert(button: buttonAnswerB) : showWrongAnswerAlert(button: buttonAnswerB)
    }
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
        buttonAnswerC.title(for: .normal) == question?.correctAnswer ? showRightAnswerAlert(button: buttonAnswerC) : showWrongAnswerAlert(button: buttonAnswerC)
    }
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        buttonAnswerD.title(for: .normal) == question?.correctAnswer ? showRightAnswerAlert(button: buttonAnswerD) : showWrongAnswerAlert(button: buttonAnswerD)
    }
    
    private func showWrongAnswerAlert(button: UIButton) {
        button.backgroundColor = .red
        let alertController = UIAlertController(title: "Wrong!", message: "try again", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "oh my..", style: UIAlertAction.Style.default, handler: { [weak self] (_) in
                self?.goToNextScreen()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showRightAnswerAlert(button: UIButton) {
        haveWon = true
        rightAnswers += 1
        button.backgroundColor = .green
        let alertController = UIAlertController(title: "Right Answer!", message: "Go on..", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes!", style: UIAlertAction.Style.default, handler: { [weak self] (_) in
            self?.goToNextScreen()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func goToNextScreen() {
        guard !questions.isEmpty,
            let questionViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController
        else {
            performSegue(withIdentifier: "ResultView", sender: nil)
            return
        }
        questionViewController.questions = questions
        questionViewController.numberOfQuestions = numberOfQuestions
        questionViewController.rightAnswers = rightAnswers
        questionViewController.categories = categories
        questionViewController.difficulty = difficulty
        navigationController?.pushViewController(questionViewController, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.resultView.resultLabel.lineBreakMode = .byWordWrapping
            resultViewController.resultView.resultLabel.numberOfLines = 0
            resultViewController.resultView.resultLabel.text = "You got \(rightAnswers) right from \(numberOfQuestions) questions. \nCategories: \(categories) \nDifficulty: \(difficulty)"
        }
    }
    

}
