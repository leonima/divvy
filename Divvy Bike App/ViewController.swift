//
//  ViewController.swift
//  Divvy Bike App
//
//  Created by Ziyun Ma on 6/26/17.
//  Copyright © 2017 Ziyun Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var myTableView: UITableView!
    
    var bikeStations = [[String: String]]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let urlString = "https://feeds.divvybikes.com/stations/stations.json"
        let url = URL(string: urlString)
        let myData = try? Data(contentsOf: url!, options: [])
        let json = JSON(myData)
        parse(myData: json)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bikeStations.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let divvyStations = bikeStations[indexPath.row]
        cell.textLabel?.text = divvyStations["stationName"]
        cell.detailTextLabel?.text = "Available docks: \(divvyStations["availableDocks"]!)" + " " + "Total docks: \(divvyStations["totalDocks"]!)"

        return cell
    }
    
    func parse(myData:JSON)
    {
        for elements in myData["stationBeanList"].arrayValue
        {
            let stationName = elements["stationName"].stringValue
            let availableDocks = elements["availableDocks"].stringValue
            let totalDocks = elements["totalDocks"].stringValue
            let latitude = elements["latitude"].stringValue
            let longitude = elements["longitude"].stringValue
            let city = elements["city"].stringValue
            
            let object = ["stationName": stationName, "availableDocks": availableDocks, "totalDocks": totalDocks, "latitude": latitude, "longitude": longitude, "city": city]
            bikeStations.append(object)
        }
        myTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "yo"
        {
            let divvyStation = bikeStations[indexPath.row]
            let dvc = segue.destination as! DetailViewController
            dvc.detailItem = divvyStation
        }
        if let indexPath = myTableView.indexPathForSelectedRow
        {
            let divvyStation = bikeStations[indexPath.row]
            let mvc = segue.destination as! MapViewController
            mvc.detailItemTwo = divvyStation
        }
    }
}

