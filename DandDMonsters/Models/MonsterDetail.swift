//
//  MonsterDetail.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 25/05/2025.
//

import Foundation

@Observable
class MonsterDetail {
    
    var urlString: String = ""
    var size: String = ""
    var type: String = ""
    var alignment: String = ""
    var hit_points: Int = 0
    var imageURL: String = ""
   
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
           
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our data structures
            guard let returned = try? JSONDecoder().decode(MonsterInfo.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
               
                return
            }
            Task { @MainActor in
                self.size = returned.size
                self.type = returned.type
                self.alignment = returned.alignment
                self.hit_points = returned.hit_points
                self.imageURL = "https://www.dnd5eapi.co" + (returned.image ?? "n/a")
               
            }
            
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
          
        }
    }
}
