//
//  MonsterDetail.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 25/05/2025.
//

import Foundation

@Observable
class MonsterDetail {
    private struct Returned: Codable {
        var size: String
        var type: String
        var alignment: String
        var hit_points: Int
        var image: String?
    }
    
    var urlString: String = ""
    var size: String = ""
    var type: String = ""
    var alignment: String = ""
    var hit_points: Int = 0
    var imageURL: String = ""
    var isLoading = false
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        isLoading = true
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            Task { @MainActor in
                self.size = returned.size
                self.type = returned.type
                self.alignment = returned.alignment
                self.hit_points = returned.hit_points
                self.imageURL = "https://www.dnd5eapi.co" + (returned.image ?? "n/a")
                isLoading = false
            }
            
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
            isLoading = false
        }
    }
}
