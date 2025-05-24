//
//  DetailView.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 24/05/2025.
//

import SwiftUI

struct DetailView: View {
    let monster: Monster
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(monster.name)
                .font(Font.custom("Avenir Next Condensed", size: 40))
                .bold()
                .minimumScaleFactor(0.2)
                .lineLimit(1)
            
            Rectangle()
                .frame(height: 0)
                .foregroundStyle(.gray)
                .padding(.bottom)
         
            HStack {
                VStack(alignment:.leading) {
                    Text("Type:")
                        .font(.title2)
                        .bold()
                    Text("Monstrosity")
                        .font(.title2)
                }
                .frame(width: 160,alignment: .leading)
                .border(Color.gray, width: 0.5)
                Spacer()
                VStack(alignment:.leading) {
                    Text("Size:")
                        .font(.title2)
                        .bold()
                    Text("Gargantuan")
                        .font(.title2)
                }
                .frame(width: 130,alignment: .leading)
                .border(Color.gray, width: 0.5)
            }
            .padding(.bottom)
            
            HStack {
                VStack(alignment:.leading) {
                    Text("Alignment:")
                        .font(.title2)
                        .bold()
                    Text("Any Non-Lawful Alignment")
                        .font(.title2)
                }
                .frame(width: 160,alignment: .leading)
                .border(Color.gray, width: 0.5)
                Spacer()
                VStack(alignment:.leading) {
                    Text("Hit Points:")
                        .font(.title2)
                        .bold()
                    Text("199")
                        .font(.title2)
                }
                .frame(width: 130,alignment: .leading)
                .border(Color.gray, width: 0.5)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailView(monster: Monster(index: "aboleth", name: "Androsphinx", url: "/api/2014/monsters/aboleth"))
}
