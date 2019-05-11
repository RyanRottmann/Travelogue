//
//  EntriesViewController.swift
//  Travelogue
//
//  Created by Ryan Rottmann on 5/10/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//

import UIKit
import CoreData

class EntriesViewController: UIViewController {

    @IBOutlet weak var entriesTableView: UITableView!
    var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchEntries()
        entriesTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    func fetchEntries(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            entries = [Entry]()
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "entryTitle", ascending: true)]
        do{
            entries = try
                managedContext.fetch(fetchRequest)
        } catch{
            alertNotifyUser(message: "Fetch for Entries failed")
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "entrySegue", sender: self)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.deleteEntry(indexPath: indexPath)
        }
        
        return [deleteAction]
    }
    
    func deleteEntry(indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        
        if let managedObjectContext = entry.managedObjectContext {
            managedObjectContext.delete(entry)
            
            do {
                try managedObjectContext.save()
                self.entries.remove(at: indexPath.row)
                entriesTableView.reloadData()
            } catch {
                alertNotifyUser(message: "Delete failed.")
                entriesTableView.reloadData()
            }
        }
    }
}
extension EntriesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        cell.textLabel?.text = entries[indexPath.row].entryTitle
        return cell
    }

    
}
