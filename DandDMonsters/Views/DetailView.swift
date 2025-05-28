//
//  DetailView.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 24/05/2025.
//

import SwiftUI

struct DetailView: View {
    let monster: Monster
    @State private var monsterDetail = MonsterDetail()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(monster.name)
                .font(Font.custom("Avenir Next Condensed", size: 40))
                .bold()
                .minimumScaleFactor(0.2)
                .lineLimit(1)
                .padding(.bottom)
//
//            Rectangle()
//                .frame(height: 0)
//                .foregroundStyle(.gray)
//                .padding(.bottom)
         
            HStack {
                VStack(alignment:.leading) {
                    Text("Type:")
                        .font(.title2)
                        .bold()
                    Text(monsterDetail.type.capitalized)
                        .font(.title2)
                }
                .frame(width: 160,alignment: .topLeading)
//                .border(Color.gray, width: 0.5)
                Spacer()
                VStack(alignment:.leading) {
                    Text("Size:")
                        .font(.title2)
                        .bold()
                    Text(monsterDetail.size)
                        .font(.title2)
                }
                .frame(width: 130,alignment: .topLeading)
//                .border(Color.gray, width: 0.5)
            }
            .padding(.bottom)
            
            HStack {
                VStack(alignment:.leading) {
                    Text("Alignment:")
                        .font(.title2)
                        .bold()
                    Text(monsterDetail.alignment.capitalized)
                        .font(.title2)
                }
                .frame(width: 160,height: 100,alignment: .topLeading)
//                .border(Color.gray, width: 0.5)
                Spacer()
                VStack(alignment:.leading) {
                    Text("Hit Points:")
                        .font(.title2)
                        .bold()
                    Text("\(monsterDetail.hit_points)")
                        .font(.title2)
                }
                .frame(width: 130,height: 100,alignment: .topLeading)
//                .border(Color.gray, width: 0.5)
            }
//            .padding(.bottom, 10.0)
            
            
                AsyncImage(url: URL(string: monsterDetail.imageURL)) { phase in
                    if let image = phase.image { // We have a valid image
                        image
                            .resizable()
                            .scaledToFit()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 8, x: 5, y: 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            }
                    } else if phase.error != nil { // We've had an error
                        Image(systemName: "questionmark.square.dashed")
                            .resizable()
                            .scaledToFit()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 8, x: 5, y: 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            }
                    } else { // use a placeholder - image loading
                        ProgressView()
                            .tint(.red)
                            .scaleEffect(5)
                           
                    }
                }
                .frame(maxWidth: .infinity)
//                .padding()
            
            Spacer()
        }
        .padding()
        
        .task {
            monsterDetail.urlString = "https://www.dnd5eapi.co" + monster.url
            await monsterDetail.getData()
        }
    }
}

#Preview {
    DetailView(monster: Monster(index: "aboleth", name: "Androsphinx", url: "/api/2014/monsters/aboleth"))
}
