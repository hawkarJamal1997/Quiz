//
//  HighscoreTableViewController.swift
//  JU Quiz
//
//  Created by hawkar on 2020-11-19.
//

import UIKit
import CoreData

class HighscoreTableViewController: UITableViewController {

    var fetchedResultController: NSFetchedResultsController<GameResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "highscoreIdentifier")
        setupFetchResultController()
    }
    private func setupFetchResultController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<GameResult>(entityName: "GameResult")
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [dateSort]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            fatalError("Failed to initalize fetchResultController")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highscoreIdentifier", for: indexPath)

        let gameResult = fetchedResultController.object(at: indexPath)
        var rights: Double = Double(gameResult.rightAnswers) / Double(gameResult.numberOfQuestions) * 100
        rights = round(rights)
        let winrate = String(format: "%.f%%", rights)
        cell.textLabel?.text = "Out of \(gameResult.numberOfQuestions) you answered \(gameResult.rightAnswers) right (\(winrate))"

        return cell
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

extension HighscoreTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected this row: \(indexPath.row)")
    }
    
}
