//
//  ContentView.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 23/05/2025.
//

import SwiftUI

struct MonstersListView: View {
    @State var monsters = Monsters()
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("\(monsters.monstersArray.count) Monsters")
                    }
                }
                if monsters.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.red)
                }
                
            }
        }
        
        .task {
            await monsters.getData()
        }
    }
}

#Preview {
    MonstersListView()
}
