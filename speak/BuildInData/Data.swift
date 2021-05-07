//
//  Data.swift
//  speak
//
//  Created by Anya Akbar on 29/04/21.
//

import Foundation





public struct Challenge {
    var labelMinute : Int = 0
    var secondsPerChallenge : Int = 0
    var title : String = ""
    
    static func generateDataChallenge() -> [Challenge]{
        return [Challenge(labelMinute: 1/4, secondsPerChallenge: 15, title: "15 Seconds"),Challenge(labelMinute: 1, secondsPerChallenge: 60, title: "1 Minute"), Challenge(labelMinute: 2, secondsPerChallenge: 120, title: "2 Minute"), Challenge(labelMinute: 5, secondsPerChallenge: 300, title: "5 Minute"), Challenge(labelMinute: 10, secondsPerChallenge: 600, title: "10 Minute"), Challenge(labelMinute: 15, secondsPerChallenge: 900, title: "15 Minute")]
        
    }
    
    static func generateRandomTopics() -> [String]{
        return
       [ "Flower that you love", "Your Favorite Books", "Latest Tech You Know", "Self improvement", "Time Management", "Music", "Series vs K-Drama", "Learning vs Cramming", "Data Science", "Industry 4.0", "Boba Drink vs Coffee", "Whatever that you want to talk right now!"]
    }
}



