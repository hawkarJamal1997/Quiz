//
//  QuestionViewController.swift
//  JU Quiz
//
//  Created by Hawkar Jamal Ali on 2020-10-29.
//

import UIKit

class QuestionViewController: UIViewController {


    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var buttonAnswerA: UIButton!
    @IBOutlet weak var buttonAnswerB: UIButton!
    @IBOutlet weak var buttonAnswerC: UIButton!
    @IBOutlet weak var buttonAnswerD: UIButton!
    @IBOutlet var questionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionView.layer.contents = #imageLiteral(resourceName: "appBackground.png" ).cgImage
        //question label
        labelQuestion.layer.cornerRadius = 20
        labelQuestion.layer.masksToBounds = true
        
        [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD].forEach { (button) in
            button?.layer.cornerRadius = 10
            buttonAnswerA.layer.shadowOpacity = 0.7
            buttonAnswerA.layer.shadowOffset = CGSize(width: 4, height: 4)
            buttonAnswerA.layer.shadowRadius = 15.0
            buttonAnswerA.layer.shadowColor = UIColor.darkGray.cgColor
        }
    }
    
    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        showWrongAnswerAlert(button: buttonAnswerA)
    }
    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        showWrongAnswerAlert(button: buttonAnswerB)
    }
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
      showRightAnswerAlert(button: buttonAnswerC)
    }
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        showWrongAnswerAlert(button: buttonAnswerD)
    }
    
    private func showWrongAnswerAlert(button: UIButton) {
        button.backgroundColor = .red
        let alertController = UIAlertController(title: "Wrong!", message: "try again", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "oh my..", style: UIAlertAction.Style.default, handler: { (_) in
            alertController.dismiss(animated: true, completion:nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showRightAnswerAlert(button: UIButton) {
        button.backgroundColor = .green
        let alertController = UIAlertController(title: "Right Answer!", message: "Go on..", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes!", style: UIAlertAction.Style.default, handler: { (_) in
            alertController.dismiss(animated: true, completion:nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
