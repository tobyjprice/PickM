//
//  Player.swift
//  PickM
//
//  Created by Toby Price on 18/01/2017.
//  Copyright © 2017 Toby Price. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

var playerDat = Player()

class Player
{
    var steamId = "76561198034432280" //nascaptain account id
    var userKey = "9BP6-HBXHB-J3CE" //Event 11 ELEAGUE Atlanta Jan 2017 key for nascaptain
    var picks: [PlayerPick] = []
 
    func load()
    {
        // Url
        let scriptUrl = "https://api.steampowered.com/ICSGOTournaments_730/GetTournamentPredictions/v1"
        
        // Add parameters
        let urlString = scriptUrl + "?key=\(eventDat.webKey)&event=\(eventDat.id)&steamid=\(steamId)&steamidkey=\(userKey)"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url as URL, options: []) {
                let json = JSON(data: data)
                
                if json["result"]["picks"].exists() {
                    parsePlayerPicks(json)
                }
            }
        }
    }
    
    func parsePlayerPicks(_ json: JSON) {
        for result in json["result"]["picks"].arrayValue {
            var tmpPick = PlayerPick()
            tmpPick.groupId = result["groupid"].intValue
            tmpPick.index = result["index"].intValue
            tmpPick.pick = result["pick"].intValue
            
            picks.append(tmpPick)
        }
    }

}

struct PlayerPick
{
    var groupId = 0
    var index = 0
    var pick = 0
}
