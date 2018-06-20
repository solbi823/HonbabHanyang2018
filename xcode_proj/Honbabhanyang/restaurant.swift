//
//  restaurant.swift
//  Honbabhanyang
//
//  Created by hojun on 19/04/2018.
//  Copyright © 2018 hojun. All rights reserved.
//

import Foundation
let fileName = "History.brch"

var partyNumber : Int = 0
var currentlyInParty : Int = -1 // for checking if the user is already in a party 

// Class for saving current restaurant data
class RestaurantData {
    var restaurants : [Restaurant] = []
    
    init(){
    }
}

// Class for representing Restaurants and party for the restaurant
class Restaurant {
    let id : Int // id used for accesssing
    let name: String
    let region: Region
    let genre: Genre
    var phoneNumber: String
    
    var parties: [Party]?
    
    init(id: Int, name: String, region: Region, genre :Genre, phoneNumber: String){
        self.id = id
        self.name = name
        self.region = region
        self.genre = genre
        self.phoneNumber = phoneNumber
    }
}

class User {
    // user ID
}

// party class for matching people
class Party {
    let partyID: Int
    let maxPeople :Int
    let menu : String
    var currentPeople : Int
    
    var users : [User]? = []
    
    init(menu: String , maxPeople : Int){
        
        self.partyID = partyNumber
        partyNumber += 1
        
        self.maxPeople = maxPeople
        self.menu = menu
        self.currentPeople = 0
    }
}

// Regions
enum Region: Int {
    case 사근동
    case 왕십리
    case 왕십리엔터식스
    case 한양대엔터식스및근처
    case 상왕십리
    
    // function that returns the number of cases in "Region"
    static let count: Int = {
        var max: Int = 0
        while let _ = Region(rawValue: max) { max += 1 }
        return max
    }()
    
    // function to get "Region" enum by String
    static func enumFromString(string: String) -> Region? {
        var i = 0
        while let item = Region(rawValue: i) {
            if "\(item)" == string { return item }
            i += 1
        }
        return nil
    }
}

// Genres
enum Genre: Int {
    case 한식
    case 중국집
    case 치킨
    case 양식
    case 분식
    case 일식
    case 고기
    case 패스트푸드
    case 세계음식
    
    // function that returns the number of cases in "Genre"
    static let count: Int = {
        var max: Int = 0
        while let _ = Genre(rawValue: max) { max += 1 }
        return max
    }()
    
    // function to get "Genre" enum by String
    static func enumFromString(string: String) -> Genre? {
        var i = 0
        while let item = Genre(rawValue: i) {
            if "\(item)" == string { return item }
            i += 1
        }
        return nil
    }
}


// 아카이브 저장 - 매칭시 저장하도록
/*
 let data = HistoryCenter(_party: Party(menu: beta.text!, maxPeople: Int(alpha.text!)!))
 data.save()
 */

class HistoryCenter {
    var historyData:[saveParty] = []
    var filePath : String {
        get {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            return documentDirectory + fileName
        }
    }
    init () {}
    init(rest:Restaurant, user1ID:String, user2ID:String) {
        if FileManager.default.fileExists(atPath: filePath) {
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile:filePath) as? [saveParty] {
                self.historyData += unarchArray
            }
        }
        self.historyData += [saveParty(rest : rest, user1ID: user1ID, user2ID: user2ID)]
    }
    func reset() {
        self.historyData = []
        NSKeyedArchiver.archiveRootObject(self.historyData, toFile:self.filePath)
    }
    func save() {
        NSKeyedArchiver.archiveRootObject(self.historyData, toFile:self.filePath)
    }
}

class saveParty : NSObject, NSCoding{
    //let party : Party?
    let date : String
    let partyID: Int
    let maxPeople :Int
    let menu : String
    let restName : String
    let restPhone : String
    let restGenre : String
    let restRegion : String
    let user1 : String
    let user2 : String
    
    init (rest:Restaurant, user1ID:String, user2ID:String) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.date = dateFormatter.string(from: now)
        if let party = rest.parties {
            let selected = party[party.count - 1]
            self.partyID = selected.partyID
            self.maxPeople = selected.maxPeople
            self.menu = selected.menu
        }
        else {
            self.partyID = 0
            self.maxPeople = 0
            self.menu = ""
        }
        self.restName = rest.name
        self.restPhone = rest.phoneNumber
        self.restGenre = "\(rest.genre)"
        self.restRegion = "\(rest.region)"
        self.user1 = user1ID
        self.user2 = user2ID
        //self.party = _party
    }
    required init? (coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        self.partyID = aDecoder.decodeInteger(forKey: "partyID")
        self.maxPeople = aDecoder.decodeInteger(forKey: "maxPeople")
        self.menu = aDecoder.decodeObject(forKey: "menu") as? String ?? ""
        self.restName = aDecoder.decodeObject(forKey: "restName") as? String ?? ""
        self.restPhone = aDecoder.decodeObject(forKey: "restPhone") as? String ?? ""
        self.restGenre = aDecoder.decodeObject(forKey: "restGenre") as? String ?? ""
        self.restRegion = aDecoder.decodeObject(forKey: "restRegion") as? String ?? ""
        self.user1 = aDecoder.decodeObject(forKey: "user1") as? String ?? ""
        self.user2 = aDecoder.decodeObject(forKey: "user2") as? String ?? ""
        //self.party = aDecoder.decodeObject(forKey: "party") as? Party
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.partyID, forKey: "partyID")
        aCoder.encode(self.maxPeople, forKey: "maxPeople")
        aCoder.encode(self.menu, forKey: "menu")
        aCoder.encode(self.restName, forKey: "restName")
        aCoder.encode(self.restPhone, forKey: "restPhone")
        aCoder.encode(self.restGenre, forKey: "restGenre")
        aCoder.encode(self.restRegion, forKey: "restRegion")
        aCoder.encode(self.user1, forKey: "user1")
        aCoder.encode(self.user2, forKey: "user2")
        //aCoder.encode(self.party, forKey: "party")
    }
}


/*func getRestaurant() -> [Restaurant] {
    return [
    Restaurant.init(name: "다시올치킨", region: .사근동, genre: .한식, phoneNumber: "123123"),
    Restaurant.init(name: "Thai in Plate", region: .사근동, genre: .세계음식, phoneNumber: "123123"),
    Restaurant.init(name: "일락", region: .왕십리, genre: .일식,  phoneNumber: "123123"),
    Restaurant.init(name: "자연별곡", region: .한양대엔터식스및근처,  genre: .한식, phoneNumber: "123123"),
    Restaurant.init(name: "악어떡볶이", region: .왕십리, genre: .분식,  phoneNumber: "123123"),
    Restaurant.init(name: "금계찜닭", region: .왕십리, genre: .한식,  phoneNumber: "123123"),
    Restaurant.init(name: "맥도날드", region: .한양대엔터식스및근처,  genre: .패스트푸드, phoneNumber: "123123"),
    Restaurant.init(name: "호남감자탕", region: .왕십리, genre: .한식,  phoneNumber: "123123"),
    Restaurant.init(name: "육앤샤", region: .왕십리, genre: .고기,  phoneNumber: "123123"),
    Restaurant.init(name: "금룡", region: .왕십리, genre: .중국집,  phoneNumber: "123123")
]
}*/
