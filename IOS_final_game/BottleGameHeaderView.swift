//
//  BottleGameHeaderView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

struct GameHeaderView: View {
    @Binding var gameMessage: String
    var correctSequenceToDisplay: [CupColor]?
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // MARK: - 第一列：火柴人與對話框 (文字訊息)
            HStack(alignment: .bottom) {
                Image("matchstick_man")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.trailing, -20)

                Text(gameMessage)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.7)
                    .padding(25)
                    .frame(minWidth: 180, maxWidth: .infinity, minHeight: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(radius: 3)
                    )
                    .overlay(
                        Triangle()
                            .fill(Color.white)
                            .frame(width: 25, height: 20)
                            .rotationEffect(.degrees(180))
                            .offset(x: -15, y: 0)
                        , alignment: .leading
                    )
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)

            // MARK: - 第二列：勝利時顯示正確順序的杯子
            if let sequence = correctSequenceToDisplay, !sequence.isEmpty {
                let totalCups = sequence.count
                let firstRowItemCount = (totalCups + 1) / 2

                let firstRowCups = Array(sequence.prefix(firstRowItemCount))
                let secondRowCups = Array(sequence.suffix(max(0, totalCups - firstRowItemCount)))

                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        ForEach(firstRowCups) { cupColor in
                            CupView(color: cupColor, isTarget: true, customSize: CGSize(width: 40, height: 55))
                        }
                    }

                    if !secondRowCups.isEmpty {
                        HStack(spacing: 5) {
                            ForEach(secondRowCups) { cupColor in
                                CupView(color: cupColor, isTarget: true, customSize: CGSize(width: 40, height: 55))
                            }
                        }
                    }
                }
                .cornerRadius(10)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.5), value: sequence.count)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.2))
    }
}
