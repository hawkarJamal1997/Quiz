//
//  InformationViewController.swift
//  JU Quiz
//
//  Created by Hawkar Jamal Ali on 2020-11-04.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet var infoView: UIView!
    @IBOutlet weak var infoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.layer.contents = #imageLiteral(resourceName: "info.jpg").cgImage
        self.infoImage.image = #imageLiteral(resourceName: "infoProfile.png")
        // Do any additional setup after loading the view.
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
