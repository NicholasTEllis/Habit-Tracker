//
//  HabitListTableViewController.swift
//  Habit Tracker
//
//  Created by Nicholas Ellis on 2/15/17.
//  Copyright © 2017 Nicholas Ellis. All rights reserved.
//

import UIKit
import CoreData
import Social
import FBSDKShareKit
import UserNotifications

class HabitListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, HabitTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchedResultsController.delegate = self
        self.tableView.backgroundColor = Keys.shared.background
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Error starting fetched results controller: \(error)")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0 }
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath) as? HabitTableViewCell
        
        cell?.delegate = self
        cell?.habit = fetchedResultsController.object(at: indexPath)
        
        return cell ?? HabitTableViewCell()
    }
    
    // MARK: - Swipe to complete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    // MARK: - Complete/uncomplete swipe actions
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let habit = fetchedResultsController.object(at: indexPath)
        var completeAction: UITableViewRowAction?
        if habit.isCompleteToday == false {
            completeAction = UITableViewRowAction(style: .default, title: Keys.shared.swipeToCompleteString) { (_, indexPath) in
                self.isEditing = false
                DailyCompletionController.shared.completeHabitForDay(habit: habit)
            }
        } else {
            completeAction = UITableViewRowAction(style: .default, title: Keys.shared.swipeToUndoCompletion, handler: { (_, indexPath) in
                self.isEditing = false
                DailyCompletionController.shared.undoCompleteHabitForDay(habit: habit)
            })
        }
        
        //        completeAction.backgroundColor = HabitController.shared.habits[indexPath.row].iconColor // TODO: -  fix this with whatever Sohail names the color property on the habit model
        guard let swipeMenuAction = completeAction else { return [] }
        return [swipeMenuAction]
    }
    
    
    // MARK: - HabitTableViewCellDelegate
    
    func presentTwitterController() {
        presentTweetUponHabitFailure()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHabitDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? HabitDetailViewController {
                    let habit = fetchedResultsController.object(at: indexPath)
                    destinationVC.habit = habit
                }
            }
        }
    }
    
    func presentTweetUponHabitFailure() {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            guard let tweetController = SLComposeViewController(forServiceType: SLServiceTypeTwitter) else {
                return
            }
            tweetController.setInitialText("I failed my habit")
            present(tweetController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to Twitter", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (UIAlertAction) in
                let settingsURL = URL(string: "\(UIApplication.openAppSettings())")
                if let url = settingsURL {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - NSFetchedResultsController
    
    let fetchedResultsController: NSFetchedResultsController<Habit> = {
        let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        let sortDescriptors = [NSSortDescriptor(key: "isCompleteToday", ascending: true), NSSortDescriptor(key: "startDate", ascending: true)]
        fetchRequest.sortDescriptors = sortDescriptors
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isCompleteToday", cacheName: nil)
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        // TODO: - We need to decide which of these cases we need.
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .update:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchedResultsController.sections,
            let index = Int(sections[section].name) else {
                return "The title for header is broken" }
        return index == 0 ? "To Do" : "Completed Today"
    }
}
