//
//  EventClass.swift
//  PickM
//
//  Created by Toby Price on 17/01/2017.
//  Copyright © 2017 Toby Price. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

var eventDat = Event()

class Event {
    let webKey = "30EB9854800661241D12932808F0C408" //nascaptain csgo webkey
    var steamId = "76561198034432280" //nascaptain account id
    var userKey = "9BP6-HBXHB-J3CE" //Event 11 ELEAGUE Atlanta Jan 2017 key for nascaptain
    
    var id = 11
    var name = ""
    var sections: [Section] = []
    
    func load()
    {
        // Url
        let scriptUrl = "https://api.steampowered.com/ICSGOTournaments_730/GetTournamentLayout/v1"
        
        // Add parameters
        let urlString = scriptUrl + "?key=\(webKey)&event=\(id)"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url as URL, options: []) {
                let json = JSON(data: data)
                
                if json["result"]["event"].intValue == id {
                    parseEventLayout(json)
                    populate_Teams()
                }
            }
        }
        
        
    }
    
    func parseEventLayout(_ json: JSON) {
        name = json["result"]["name"].stringValue
        for result in json["result"]["sections"].arrayValue {
            let tmpSection = Section()
            tmpSection.name = result["name"].stringValue
            tmpSection.id = result["sectionid"].intValue
            
            for group in result["groups"].arrayValue {
                let tmpGroup = Group()
                tmpGroup.id = group["groupid"].intValue
                tmpGroup.name = group["name"].stringValue
                tmpGroup.points = group["points_per_pick"].intValue
                tmpGroup.picksAllowed = group["picks_allowed"].bool!
                
                for team in group["teams"].arrayValue {
                    let tmpTeam = Team()
                    tmpTeam.id = team["pickid"].intValue
                    tmpGroup.teams.append(tmpTeam)
                }
                
                for pick in group["picks"].arrayValue {
                    let tmpPick = Pick()
                    tmpPick.index = pick["index"].intValue
                    tmpPick.id = pick["pickids"][0].intValue
                    tmpGroup.picks.append(tmpPick)
                }
                
                tmpSection.groups.append(tmpGroup)
            }
            
            sections.append(tmpSection)
        }
    }
    
    func populate_Teams()
    {
        for team in sections[0].groups[0].teams
        {
            switch team.id
            {
            case 60:
                team.name = "Astralis"
                team.logo = #imageLiteral(resourceName: "astr")
                break
            case 46:
                team.name = "EnVyUs"
                team.logo = #imageLiteral(resourceName: "nv")
                break
            case 61:
                team.name = "FaZe"
                team.logo = #imageLiteral(resourceName: "faze")
                break
            case 43:
                team.name = "FlipSide"
                team.logo = #imageLiteral(resourceName: "flip")
                break
            case 6:
                team.name = "Fnatic"
                team.logo = #imageLiteral(resourceName: "fntc")
                break
            case 59:
                team.name = "G2"
                team.logo = #imageLiteral(resourceName: "g2")
                break
            case 63:
                team.name = "Gambit"
                team.logo = #imageLiteral(resourceName: "gamb")
                break
            case 67:
                team.name = "Godsent"
                //team.logo = god
                break
            case 25:
                team.name = "Hellraisers"
                //team.logo = hlr
                break
            case 29:
                team.name = "Mousesports"
                team.logo = #imageLiteral(resourceName: "mss")
                break
            case 12:
                team.name = "Na'Vi"
                team.logo = #imageLiteral(resourceName: "navi")
                break
            case 68:
                team.name = "North"
                //team.logo = nor
                break
            case 66:
                team.name = "Optic Gaming"
                team.logo = #imageLiteral(resourceName: "optc")
                break
            case 14:
                team.name = "SK Gaming"
                team.logo = #imageLiteral(resourceName: "sk")
                break
            case 48:
                team.name = "Liquid"
                team.logo = #imageLiteral(resourceName: "liq")
                break
            case 31:
                team.name = "Virtus Pro"
                team.logo = #imageLiteral(resourceName: "vp")
                break
            default:
                break
            }
        }
    }
}

class Section {
    var id = 0
    var name = ""
    var groups: [Group] = []
}

class Group {
    var id = 0
    var name = ""
    var points = 0
    var picksAllowed = false
    var teams: [Team] = []
    var picks: [Pick] = []
}

class Team {
    var id = 0
    var name = ""
    var logo: UIImage?
}

class Pick {
    var index = 0
    var id = 0
}
