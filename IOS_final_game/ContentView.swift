//
//  ContentView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("...遊戲")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.bottom, 50)

                NavigationLink(destination: BottleChoose()) {
                    Text("瓶子")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 80)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .padding(.bottom, 20)

                NavigationLink(destination: PeopleChoose()) {
                    Text("房子")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 80)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }

                Spacer()
            }
            .navigationBarHidden(true)
            .navigationTitle("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
