//
//  StartViewController.swift
//  JU Quiz
//
//  Created by hawkar on 2020-11-16.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController {
            let question1 = Question(category: "Pet", type: .multiple, difficulty: .easy, question: "What is the best pet?", correctAnswer: "🦖", incorrectAnswer: ["🐕", "🐈", "🦒"])
            let question2 = Question(category: "Sport", type: .multiple, difficulty: .easy, question: "What is the best sport?", correctAnswer: "⚽️", incorrectAnswer: ["🏈", "🎾", "🏀"])
            
            let questions = [question1, question2, question1]
            questionViewController.numberOfQuestions = questions.count
            questionViewController.questions = questions
        }
    }

}
