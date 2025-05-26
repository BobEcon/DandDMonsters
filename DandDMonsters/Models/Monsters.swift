//
//  Monsters.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 23/05/2025.
//

import Foundation

@Observable
class Monsters {
    private struct Returned: Codable {
        var count: Int
        var results: [Monster]
    }
    
    var urlString = "https://www.dnd5eapi.co/api/2014/monsters"
    var count = 0
    var monstersArray: [Monster] = []
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
            // Only need these if bug in XCode 16.3 Simulator (don't need them here but we did in the CatchEmAll app)
            //            let configuration = URLSessionConfiguration.ephemeral
            //            let session = URLSession(configuration: configuration)
            //            let (data, _) = try await session.data(from: url)
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            Task { @MainActor in
                self.count = returned.count
                self.monstersArray = returned.results
                isLoading = false
            }
            
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
            isLoading = false
        }
    }
}
