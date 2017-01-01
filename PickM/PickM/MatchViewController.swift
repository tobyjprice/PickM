//
//  MatchViewController.swift
//  PickM
//
//  Created by Toby Price on 26/09/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var day: Int?
    var match: Int?

    @IBOutlet var teamPlayersTableView: UITableView!
    @IBOutlet weak var teamLogoImgView1: UIImageView!
    @IBOutlet weak var teamLogoImgView2: UIImageView!
    @IBOutlet weak var teamNameLabel1: UILabel!
    @IBOutlet weak var teamNameLabel2: UILabel!
    @IBOutlet weak var teamPickButton1: UIButton!
    @IBOutlet weak var teamPickButton2: UIButton!
    
    @IBAction func teamPickButton1Down(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { self.teamPickButton1.backgroundColor = customTint }, completion: nil)
        teamPickButton1.setTitleColor(customBg1, for: .highlighted)
    }
    
    @IBAction func teamPickButton1Up(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { self.teamPickButton1.backgroundColor = UIColor.clear }, completion: nil)
        teamPickButton1.setTitleColor(customTint, for: .normal)
    }
    
    @IBAction func teamPickButton2Down(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { self.teamPickButton2.backgroundColor = customTint }, completion: nil)
        teamPickButton2.setTitleColor(customBg1, for: .highlighted)
        teamPickButton2.setTitleColor(customBg1, for: .selected)
    }
    
    @IBAction func teamPickButton2Up(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { self.teamPickButton2.backgroundColor = UIColor.clear }, completion: nil)
        teamPickButton2.setTitleColor(customTint, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = customBg1
        
        let divider = UIView()
        divider.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.5)
        divider.backgroundColor = UIColor.black
        self.view.addSubview(divider)
        
        self.teamPlayersTableView.dataSource = self;
        self.teamPlayersTableView.delegate = self;
        
        teamLogoImgView1.image = #imageLiteral(resourceName: "nip")
        teamLogoImgView2.image = #imageLiteral(resourceName: "flip")
        
        teamNameLabel1.text = "Ninjas in Pyjamas"
        teamNameLabel2.text = "Flipsid3 Tactics"
        
        teamPickButton1.layer.cornerRadius = 5
        teamPickButton1.layer.borderWidth = 1
        teamPickButton1.layer.borderColor = customTint.cgColor
        
        teamPickButton2.layer.cornerRadius = 5
        teamPickButton2.layer.borderWidth = 1
        teamPickButton2.layer.borderColor = customTint.cgColor
        
        print(day)
        print(match)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ teamPlayersTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ teamPlayersTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamPlayersTableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableCell
        
        // Set selection colour
        let cView = UIView()
        cView.backgroundColor = customTint
        cell.selectedBackgroundView = cView
        cell.playerNameLabel.text = eventDat.days[day!].matches[match!].teams[0].name
        cell.tag = indexPath.row
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
