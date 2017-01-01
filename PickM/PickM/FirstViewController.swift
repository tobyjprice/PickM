//
//  FirstViewController.swift
//  PickM
//
//  Created by Toby Price on 07/07/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPageViewControllerDelegate {
    
    @IBOutlet var matchTable: UITableView!
    var cellIndex: Int?
    
    // send the page index to FirstViewCOntroller
    var pageIndex: Int?
    var eventData = Event()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //matchTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ matchTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for match in eventData.days[pageIndex!].matches {
            if match.id != nil {
                count += 1
            }
        }
        return count
    }
    
    func tableView(_ matchTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = matchTable.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchTableCell
        
        // Set selection colour
        let cView = UIView()
        cView.backgroundColor = customTint
        cell.selectedBackgroundView = cView
        cell.matchCell1.text = eventData.days[pageIndex!].matches[indexPath.row].name
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Gets the target view controller (MatchViewController) and sets the vars day and match to their values
        let targetVC = segue.destination as? MatchViewController
        let senderCell = sender as? MatchTableCell
        
        targetVC?.day = pageIndex!
        targetVC?.match = senderCell?.tag
    }
}

