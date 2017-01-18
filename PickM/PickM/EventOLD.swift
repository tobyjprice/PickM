//
//  OLD EVENT CLASS NOT TO BE USED
//
//  Event.swift
//  PickM
//
//  Created by Toby Price on 07/07/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

/*
import Foundation
import UIKit
import SwiftyJSON

var eventDat = Event()

class eventLoad {
    let webKey = "30EB9854800661241D12932808F0C408" //nascaptain csgo webkey
    var steamId = "76561198034432280" //nascaptain account id
    var userKey = "9BP6-HBXHB-J3CE" //Event 11 ELEAGUE Atlanta Jan 2017 key for nascaptain
    var players: [Player] = []
    var schPlayers: [schPlayer] = []
    
    func eventLayout() -> Event {
        // Url
        let scriptUrl = "https://api.steampowered.com/ICSGOTournaments_730/GetTournamentLayout/v1"
        
        // Add parameters
        let urlString = scriptUrl + "?key=\(webKey)&event=\(eventDat.eventId)"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url as URL, options: []) {
                let json = JSON(data: data)
                
                if json["result"]["event"].intValue == eventDat.eventId {
                    parseEventLayout(json)
                }
            }
        }
        
        setPlayers()
        teamInfo()
        getUserPicks()
        thing()
        
        return eventDat
    }
    
    func setPlayers() {
        if let path = Bundle.main.path(forResource: "PlayerList", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: path)
                let playerNames = contents.components(separatedBy: .newlines)
                
                
                for item in playerNames {
                    if item != "" {
                        let playerInfo = Player()
                        let range = item.startIndex..<item.index(item.startIndex, offsetBy: 4)
                        
                        var name = item
                        name.removeSubrange(range)
                        
                        playerInfo.name = name
                        playerInfo.portrait = UIImage.init(named: item)
                        
                        players.append(playerInfo)
                    }
                }
            } catch {
                print("Couldn't load PlayerList.txt")
            }
        } else {
            print("Could not find PlayerList.txt")
        }
    }
    
    func parseEventLayout(_ json: JSON) {
        var n = 0
        eventDat.name = json["result"]["name"].stringValue
        for result in json["result"]["sections"].arrayValue {
            let sectionName = result["name"].stringValue
            let sectionId = result["sectionid"].intValue
            var tmpStage = Stage()
            tmpStage.name = sectionName
            tmpStage.id = sectionId
            
            for group in result["groups"].arrayValue {
                
                let groupId = group["groupid"].intValue
                let groupName = group["name"].stringValue
                let pointsPerPick = group["points_per_pick"].intValue
                let picksAllowed = group["picks_allowed"].bool
                var tmpGroup = Group()
                tmpGroup.id = groupId
                tmpGroup.name = groupName
                tmpGroup.pointsPerPick = pointsPerPick
                tmpGroup.picksAllowed = picksAllowed
                
                for team in group["teams"].arrayValue {
                    let teamId = team["pickid"].intValue
                    var tmpTeam = Team()
                    tmpTeam.id = teamId
                    tmpGroup.teams.append(tmpTeam)
                }
                
                for pick in group["picks"].arrayValue {
                    let pickId = pick["pickids"][0].intValue
                    tmpGroup.picks.append(pickId)
                }
                
                tmpStage.matches.append(tmpGroup)
            }
            
            eventDat.stages.append(tmpStage)
        }
    }
    
    func getUserPicks() {
        if steamId != "" && userKey != "" {
            let picksUrl = "https://api.steampowered.com/ICSGOTournaments_730/GetTournamentPredictions/v1?key=\(webKey)&event=\(eventDat.eventId)&steamid=\(steamId)&steamidkey=\(userKey)"
            if let testUrl = URL(string: picksUrl) {
                if let data2 = try? Data(contentsOf: testUrl as URL, options: []) {
                    let json = JSON(data: data2)
                    
                    parseUserPicks(json)
                    
                }
            }
        } else {
            print("INVALID STEAMID/USERKEY")
        }
    }
    
    func parseUserPicks(_ json: JSON) {
        var n = 0
        for _ in eventDat.stages {
            for pick in json["result"]["picks"].arrayValue {
                let groupId = pick["groupid"].intValue
                let usrPick = pick["pick"].intValue
                var x = 0
                for group in eventDat.stages[n].matches {
                    if groupId == group.id {
                        eventDat.stages[n].matches[x].userPicks = [usrPick]
                    }
                    x += 1
                }
                
            }
            n += 1
        }
    }

    func teamInfo() {
        var x = 0
        for day in eventDat.stages {
            var y = 0
            for match in day.matches {
                var z = 0
                for team in match.teams {
                    switch team.id {
                    case 1?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "nip")
                        eventDat.stages[x].matches[y].teams[z].name = "Ninjas In Pyjamas"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 6?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "fntc")
                        eventDat.stages[x].matches[y].teams[z].name = "Fnatic"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 12?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "navi")
                        eventDat.stages[x].matches[y].teams[z].name = "Natus Vincere"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 14?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "sk")
                        eventDat.stages[x].matches[y].teams[z].name = "SK Gaming"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 24?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "dig")
                        eventDat.stages[x].matches[y].teams[z].name = "Team Dignitas"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 29?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "mss")
                        eventDat.stages[x].matches[y].teams[z].name = "mousesports"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 31?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "vp")
                        eventDat.stages[x].matches[y].teams[z].name = "Virtus.Pro"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 43?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "flip")
                        eventDat.stages[x].matches[y].teams[z].name = "Flipsid3 Tactics"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 46?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "nv")
                        eventDat.stages[x].matches[y].teams[z].name = "Team EnVyUs"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 48?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "liq")
                        eventDat.stages[x].matches[y].teams[z].name = "Team Liquid"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 49?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "clg")
                        eventDat.stages[x].matches[y].teams[z].name = "Counter Logic Gaming"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 59?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "g2")
                        eventDat.stages[x].matches[y].teams[z].name = "G2 Esports"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 60?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "astr")
                        eventDat.stages[x].matches[y].teams[z].name = "Astralis"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 61?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "faze")
                        eventDat.stages[x].matches[y].teams[z].name = "FaZe Clan"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 63?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "gamb")
                        eventDat.stages[x].matches[y].teams[z].name = "Gambit Gaming"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    case 66?:
                        eventDat.stages[x].matches[y].teams[z].logo = UIImage(named: "optc")
                        eventDat.stages[x].matches[y].teams[z].name = "OpTic Gaming"
                        eventDat.stages[x].matches[y].teams[z].players = teamInfo(teamId: team.id!)
                        break
                    default:
                        break
                    }
                    z += 1
                }
                y += 1
            }
            x += 1
        }
    }

    func teamInfo(teamId: Int) -> [Player] {
        print(teamId)
        var roster = [Player(), Player(), Player(), Player(), Player()]
        switch teamId {
        case 1:
            // NIP
            roster[0] = players[60]
            roster[1] = players[61]
            roster[2] = players[62]
            roster[3] = players[63]
            roster[4] = players[64]
            break;
        case 6:
            // Fnatic
            
            break;
        case 12:
            // Navi
            roster[0] = players[55]
            roster[1] = players[56]
            roster[2] = players[57]
            roster[3] = players[58]
            roster[4] = players[59]
            break;
        case 14:
            // SK
            roster[0] = players[70]
            roster[1] = players[71]
            roster[2] = players[72]
            roster[3] = players[73]
            roster[4] = players[74]
            break;
        case 24:
            // Dignitas
            break;
        case 29:
            // Mouz
            break;
        case 31:
            // VP
            roster[0] = players[75]
            roster[1] = players[76]
            roster[2] = players[77]
            roster[3] = players[78]
            roster[4] = players[79]
            break;
        case 43:
            // Flipside
            roster[0] = players[25]
            roster[1] = players[26]
            roster[2] = players[27]
            roster[3] = players[28]
            roster[4] = players[29]
            break;
        case 46:
            // EnvyUs
            break;
        case 48:
            // Liquid
            roster[0] = players[45]
            roster[1] = players[46]
            roster[2] = players[47]
            roster[3] = players[48]
            roster[4] = players[49]
            break;
        case 49:
            // CLG
            break;
        case 59:
            // G2
            break;
        case 60:
            // Astralis
            roster[0] = players[0]
            roster[1] = players[1]
            roster[2] = players[2]
            roster[3] = players[3]
            roster[4] = players[4]
            break;
        case 61:
            // Faze
            break;
        case 63:
            // Gambit
            roster[0] = players[40]
            roster[1] = players[41]
            roster[2] = players[42]
            roster[3] = players[43]
            roster[4] = players[44]
            break;
        case 66:
            // Optic
            break;
        default:
            break;
        }
        return roster
    }
    
    func thing() {
        
        // Url
        let urlString = "https://api.steampowered.com/IEconItems_730/GetSchemaURL/v2/?key=\(webKey)&format=json"
        var schemaURL = ""
        
        // Retrieves item schema url
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url as URL, options: []) {
                let json = JSON(data: data)
                if json["result"]["status"].intValue == 1 {
                    schemaURL = json["result"]["items_game_url"].stringValue
                }
            }
        }
        
        if let url = URL(string: schemaURL) {
            
            do {
                let contents = try String(contentsOf: url)
                let contents2 = contents.trimmingCharacters(in: .whitespacesAndNewlines)
                let data = contents2.components(separatedBy: .newlines)
                var tempData: [String] = []
                var startIndex = 0
                var endIndex = 0
                var playerLine = false
                
                for (index, line) in data.enumerated() {
                    if line != "" {
                        // Put things in here
                        if line == "\t\"pro_players\"" {
                            startIndex = index + 2
                            playerLine = true
                        }
                        
                        if playerLine {
                            tempData.append(line)
                            if line == "\t}" {
                                playerLine = false
                                endIndex = index - 1
                            }
                        }
                    }
                }
                recurseVDF(objName: "pro_players", data: tempData)
            } catch {
                print("Could not load")
            }
        }
    }
    
    func recurseVDF(objName: String, data: [String]) {
        var playerStart = 0
        var playerEnd = 0
        
        var playerArr: [schPlayer] = []
        var tempPlayer = schPlayer()
        var tempStage = schStage()
        
        var tempArr: [String] = []
        var playerCount = 0
        var eventCount = 0
        var stageCount = 0
        
        for (index, line) in data.enumerated() {
            var tempPlayerNum = playerCount
            
            /*if data[index] == "\t\t{" {
                playerCount += 1
            }
            
            if playerCount == tempPlayerNum {
                var tempString = line.trimmingCharacters(in: .whitespacesAndNewlines)
                var tempStringArr = tempString.components(separatedBy: .whitespaces)
                
                tempArr.append(tempStringArr[tempStringArr.count - 1].replacingOccurrences(of: "\"", with: ""))

            } */
            
            let tempLineArr = trimChars(inString: line)
            
            if line == "\t\t{" {
                tempPlayer.id = Int(trimChars(inString: data[index - 1])[0])
                //print(tempPlayer.id)
                playerStart = index - 1
            } else if line == "\t\t}" {
                playerCount += 1
                eventCount = 0
                stageCount = 0
                playerEnd = index
                tempPlayer = getPlayer(inArr: data[playerStart...playerEnd])
                playerArr.append(tempPlayer)
            }
            
            /*switch line
            {
            case "\t\t{" : // Start of player
                tempPlayer.id = Int(trimChars(inString: data[index - 1])[0])
                //print(tempPlayer.id)
                playerStart = index - 1
                break;
            case "\t\t}" : // End of player
                playerCount += 1
                eventCount = 0
                stageCount = 0
                playerEnd = index
                getPlayer(inArr: data[playerStart...playerEnd])
                break;
            default:
                switch tempLineArr[0]
                {
                case "name" :
                    tempPlayer.name = tempLineArr[2]
                    break;
                case "code" :
                    tempPlayer.code = tempLineArr[2]
                    break;
                case "dob" :
                    tempPlayer.dob = tempLineArr[2]
                    break;
                case "geo" :
                    tempPlayer.geo = tempLineArr[2]
                    break;
                default:
                    break;
                }
                
                break;
            } */
        }
        
        print("PRINTING PLAYERS")
        for player in playerArr
        {
            print(player.id, player.name, player.code, player.dob, player.geo)
            for event in player.event
            {
                print("Event ID", event.id, "Event Team", event.team!, separator: "\n")
                print("Event ID", event.totalStats.id, "Event Clutch Kills", event.totalStats.clutch_kills,"Event Pistol Kills", event.totalStats.pistol_kills, "Event Opening Kills", event.totalStats.opening_kills, "Event Sniper Kill", event.totalStats.sniper_kills, "Event KDR",event.totalStats.kdr, "Event Enemy Kills", event.totalStats.enemy_kills, "Event Deaths", event.totalStats.deaths, "Event Matches Played", event.totalStats.matches_played, separator: "\n")
                for stage in event.stages
                {
                    print(stage.id, stage.clutch_kills, stage.pistol_kills, stage.opening_kills, stage.sniper_kills, stage.kdr, stage.enemy_kills, stage.deaths, stage.matches_played, separator: "\n")
                }
            }
        }
    }
    
    func getPlayer(inArr: ArraySlice<String>) -> schPlayer {
        var tempPlayer = schPlayer()
        
        var eventStart = 0
        var eventEnd = 0
        var playerStart = inArr.startIndex
        
        //print(inArr[inArr.startIndex])
        print(inArr.count)
        
        tempPlayer.id = Int(trimChars(inString: inArr[playerStart])[0])
        tempPlayer.name = trimChars(inString: inArr[playerStart + 2])[2]
        tempPlayer.code = trimChars(inString: inArr[playerStart + 3])[2]
        tempPlayer.dob = trimChars(inString: inArr[playerStart + 4])[2]
        tempPlayer.geo = trimChars(inString: inArr[playerStart + 5])[2]
        
        for (index, line) in inArr.enumerated() {
            print(line)
            if line == "\t\t\t\t{" {
                eventStart = playerStart + index - 1
            } else if line == "\t\t\t\t}" {
                eventEnd = playerStart + index
                if eventEnd - eventStart > 11 {
                    tempPlayer.event.append(getEvent(inArr: inArr[eventStart...eventEnd]))
                }
            }
        }
        
        print(tempPlayer.name, tempPlayer.id, tempPlayer.geo, tempPlayer.event.count)
        print("GETTING")
        
        return tempPlayer
    }
    
    func getEvent(inArr: ArraySlice<String>) -> schEvent {
        let tempEvent = schEvent()
        let eventStart = inArr.startIndex
        var stageStart = 0
        var stageEnd = 0
        tempEvent.id = Int(trimChars(inString: inArr[eventStart])[0])
        if trimChars(inString: inArr[eventStart + 2])[0] != "}" {
            tempEvent.team = Int(trimChars(inString: inArr[eventStart + 2])[2])
            tempEvent.totalStats.clutch_kills = Int(trimChars(inString: inArr[eventStart + 3])[2])!
            tempEvent.totalStats.pistol_kills = Int(trimChars(inString: inArr[eventStart + 4])[2])!
            tempEvent.totalStats.opening_kills = Int(trimChars(inString: inArr[eventStart + 5])[2])!
            tempEvent.totalStats.sniper_kills = Int(trimChars(inString: inArr[eventStart + 6])[2])!
            tempEvent.totalStats.kdr = Double(trimChars(inString: inArr[eventStart + 7])[2])!
            tempEvent.totalStats.enemy_kills = Int(trimChars(inString: inArr[eventStart + 8])[2])!
            tempEvent.totalStats.deaths = Int(trimChars(inString: inArr[eventStart + 9])[2])!
            tempEvent.totalStats.matches_played = Int(trimChars(inString: inArr[eventStart + 10])[2])!
        }
        
        for (index, line) in inArr.enumerated() {
            if line == "\t\t\t\t\t{" {
                stageStart = eventStart + index - 1
            } else if line == "\t\t\t\t\t}" {
                stageEnd = eventStart + index - 1
                tempEvent.stages.append(getStage(inArr: inArr[stageStart...stageEnd], stageStart: stageStart, eventId: tempEvent.id!))
            }
        }
        return tempEvent
    }   
    
    /*func getStage(inArr: ArraySlice<String>, stageStart: Int, eventId: Int) -> schStage{
        let tempStage = schStage()
        
        if inArr.count > 7 {
            // THIS IS ALWAYS nil the stage needs its ID
            tempStage.id = Int(trimChars(inString: inArr[stageStart])[0])
            if trimChars(inString: inArr[stageStart + 2])[0] != "}" {
                tempStage.clutch_kills = Int(trimChars(inString: inArr[stageStart + 2])[2])!
                tempStage.pistol_kills = Int(trimChars(inString: inArr[stageStart + 3])[2])!
                tempStage.opening_kills = Int(trimChars(inString: inArr[stageStart + 4])[2])!
                tempStage.sniper_kills = Int(trimChars(inString: inArr[stageStart + 5])[2])!
                tempStage.kdr = Double(trimChars(inString: inArr[stageStart + 6])[2])!
                tempStage.enemy_kills = Int(trimChars(inString: inArr[stageStart + 7])[2])!
                tempStage.deaths = Int(trimChars(inString: inArr[stageStart + 8])[2])!
                tempStage.matches_played = Int(trimChars(inString: inArr[stageStart + 9])[2])!
            }
        }
        
        return tempStage
    } */
    
    func trimChars(inString: String) -> [String] {
        var tempLine = inString.trimmingCharacters(in: .whitespacesAndNewlines)
        tempLine = tempLine.replacingOccurrences(of: "\"", with: "")
        let tempLineArr = tempLine.components(separatedBy: .whitespaces)
        
        return tempLineArr
    }
}

class Event {
    var eventId = 11
    var name: String?
    var stages = [Stage]()
}

class Stage {
    var id: Int?
    var name: String?
    var matches = [Group]()
}

class Group {
    var id: Int?
    var name: String?
    var pointsPerPick: Int?
    var picksAllowed: Bool?
    var teams = [Team]()
    var picks = [Int]()
    var userPicks = [Int]()
}

class Team {
    var id: Int?
    // Name logo and players need to be added seperately
    var name: String?
    var logo: UIImage?
    //var players = [Player(), Player(), Player(), Player(), Player()]
}

class Player {
    var id: Int?
    var name: String?
    var portrait: UIImage?
}

class schPlayer {
    var id: Int?
    var name: String?
    var code: String?
    var dob: String?
    var geo: String?
    var event: [schEvent] = []
}

class schEvent {
    var id: Int?
    var team: Int?
    var totalStats = schStage()
    var stages: [schStage] = []
}

class schStage {
    var id: Int?
    var clutch_kills: Int?
    var pistol_kills: Int?
    var opening_kills: Int?
    var sniper_kills: Int?
    var kdr: Double?
    var enemy_kills: Int?
    var deaths: Int?
    var matches_played: Int?
} */
