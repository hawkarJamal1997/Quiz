//
//  QuestionViewController.swift
//  JU Quiz
//
//  Created by Hawkar Jamal Ali on 2020-10-29.
//

import UIKit
import CoreData

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
        
        questionLabel.text = question?.question.htmlDecoded
        buttons.shuffle()
        let correctButton = buttons.removeFirst()
        correctButton?.setTitle(question?.correctAnswer.htmlDecoded, for: .normal)
        
        question?.incorrectAnswers.forEach({ (answer) in
            let button = buttons.removeFirst()
            button?.setTitle(answer.htmlDecoded, for: .normal)
            
        })
    }
    
    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        let buttons = [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD]
        if buttonAnswerA.title(for: .normal) == question?.correctAnswer {
            showRightAnswerAlert(button: buttonAnswerA)
        } else {
        for button in buttons {
            if button?.title(for: .normal) == question?.correctAnswer {
                button?.backgroundColor = .green
                showWrongAnswerAlert(button: buttonAnswerA)
                break
            }
        }
        }
    }
    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        let buttons = [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD]
        if buttonAnswerB.title(for: .normal) == question?.correctAnswer {
            showRightAnswerAlert(button: buttonAnswerB)
        } else {
        for button in buttons {
            if button?.title(for: .normal) == question?.correctAnswer {
                button?.backgroundColor = .green
                showWrongAnswerAlert(button: buttonAnswerB)
                break
            }
        }
        }
    }
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
        let buttons = [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD]
        if buttonAnswerC.title(for: .normal) == question?.correctAnswer {
            showRightAnswerAlert(button: buttonAnswerC)
        } else {
        for button in buttons {
            if button?.title(for: .normal) == question?.correctAnswer {
                button?.backgroundColor = .green
                showWrongAnswerAlert(button: buttonAnswerC)
                break
            }
        }
        }
    }
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        let buttons = [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD]
        if buttonAnswerD.title(for: .normal) == question?.correctAnswer {
            showRightAnswerAlert(button: buttonAnswerD)
        } else {
        for button in buttons {
            if button?.title(for: .normal) == question?.correctAnswer {
                button?.backgroundColor = .green
                showWrongAnswerAlert(button: buttonAnswerD)
                break
            }
        }
        }
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
            saveGameResult()
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
    
    // MARK: - Saving the result
    
    private func saveGameResult() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        if let gameResult = NSEntityDescription.insertNewObject(forEntityName: "GameResult", into: managedObjectContext) as? GameResult {
            gameResult.numberOfQuestions = Int32(numberOfQuestions)
            gameResult.rightAnswers = Int32(rightAnswers)
            gameResult.date = Date()
            appDelegate.saveContext()
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.resultView.resultLabel.text = "You got \(rightAnswers) right from \(numberOfQuestions) questions. \nCategories: \(categories) \nDifficulty: \(difficulty)"
        }
    }
    

}
