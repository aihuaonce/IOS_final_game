//
//  PeopleTimeChoose.swift
//  IOS_final_game
//
//  Created by 11144155 on 2025/6/9.
//
import SwiftUI

struct PeopleTimeChoose: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("選擇遊戲時間")
                .font(.largeTitle)
                .bold()

            ForEach(GameTime.allCases, id: \.self) { timeOption in
                NavigationLink(destination:
                    PeopleGame()
                        .onAppear {
                            GameSettings.shared.gameTime = timeOption.rawValue
                        }
                ) {
                    Text(timeOption.displayText)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding()
    }
}

enum GameTime: Int, CaseIterable, Hashable {
    case thirty = 30
    case sixty = 60
    case ninety = 90

    var displayText: String {
        return "\(self.rawValue) 秒"
    }
}


