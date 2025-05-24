//
//  ContentView.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 23/05/2025.
//

import SwiftUI

struct MonstersListView: View {
    var monsters = Monsters()
    
    var body: some View {
        NavigationStack {
            List(monsters.monstersArray) { monster in
                NavigationLink {
                    DetailView(monster: monster)
                } label: {
                    Text(monster.name)
                        .font(.title2)
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Monsters:")
        }
        
        .task {
            await monsters.getData()
        }
    }
}

#Preview {
    MonstersListView()
}
