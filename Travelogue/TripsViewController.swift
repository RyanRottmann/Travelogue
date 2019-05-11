//
//  TripsViewController.swift
//  Travelogue
//
//  Created by Ryan Rottmann on 5/9/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//

import UIKit
import CoreData

class TripsViewController: UIViewController {

    @IBOutlet weak var tripsTableView: UITableView!
    var trips = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchTrips()
        tripsTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func didReceiveMemoryWarning() {
        
            super.didReceiveMemoryWarning()
        
    }
    func fetchTrips(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            trips = [Trip]()
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "tripTitle", ascending: true)]
        do{
            trips = try
            managedContext.fetch(fetchRequest)
        } catch{
            alertNotifyUser(message: "Fetch for Trips failed")
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.deleteTrip(indexPath: indexPath)
        }
        
        return [deleteAction]
    }
    
    func deleteTrip(indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        if let managedObjectContext = trip.managedObjectContext {
            managedObjectContext.delete(trip)
            
            do {
                try managedObjectContext.save()
                self.trips.remove(at: indexPath.row)
                tripsTableView.reloadData()
            } catch {
                alertNotifyUser(message: "Delete failed.")
                tripsTableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "entriesSegue", sender: self)
    }
    
}

extension TripsViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
            cell.textLabel?.text = trips[indexPath.row].tripTitle
        return cell
    }
    
}
