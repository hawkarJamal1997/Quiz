//
//  StartViewController.swift
//  JU Quiz
//
//  Created by hawkar on 2020-11-16.
//

import UIKit

class StartViewController: UIViewController {

    var questions: [Question] = []
    
    var amount = 1
    var difficulty = ""
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    
    @IBAction func buttonEasy(_ sender: Any) {
        difficulty = "easy"
    }
    
    @IBAction func buttonMedium(_ sender: Any) {
        difficulty = "medium"
    }
    
    @IBAction func buttonHard(_ sender: Any) {
        difficulty = "hard"
    }
    
    @IBAction func slider(_ sender: UISlider) {
        amount = Int(sender.value)
        sliderValueLabel.text = "Amount of Questions: \(amount)"
        downloadQuestions(amount: amount, difficulty: difficulty)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    private func downloadQuestions(amount: Int, difficulty: String)  {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)&difficulty=\(difficulty)&type=multiple")
            else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let questionsResult = try? decoder.decode(QuestionResult.self, from: data)
            self.questions = questionsResult?.results ?? []
        }
        task.resume()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController {
            questionViewController.numberOfQuestions = questions.count
            questionViewController.questions = questions
            questionViewController.difficulty = difficulty
            
            let categories = questions.map({ $0.category})
            questionViewController.categories = categories
        }
    }

}
