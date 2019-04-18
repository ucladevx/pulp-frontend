//
//  ResultsViewController.swift
//  Pulp
//
//  Created by Katherine Miao on 3/14/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController{
    
    let backgroundYellow = UIColor(red:1.00, green:0.97, blue:0.84, alpha:1.0)
    
    struct Result{
        var name: String
        var image: UIImage
        var description: String
    }
    
    let cellID = "cellID"
    var results : [Result] = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundYellow
        createResultsArray()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let currentLastItem = results[indexPath.row]
        cell.textLabel?.text = currentLastItem.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func createResultsArray(){
        results.append(Result(name:"Diddy Riese", image: #imageLiteral(resourceName: "diddyriese"), description:"..."))
        results.append(Result(name:"Sip", image: #imageLiteral(resourceName: "sip"), description:"..."))
    }
}
