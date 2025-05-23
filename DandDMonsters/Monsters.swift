//
//  Monsters.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 23/05/2025.
//

import Foundation

class Monsters {
    private struct Returned: Codable {
        var count: Int
        var results: [Monster]
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon"
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
