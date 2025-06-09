//
//  Bottle.swift
//  IOS_final_game
//
//  Created by 11144132 on 6/9/25.
//

import SwiftUI

struct BottleChoose: View {
    @State private var selectedNumberOfCups: Int? = nil
    
    let cupOptions: [Int] = [6, 7, 8, 9, 10]
    
    private func selectRandomCups() {
        selectedNumberOfCups = cupOptions.randomElement()
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()

                Text("選擇杯子數量")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 50)

                HStack(spacing: 20) {
                    ForEach(cupOptions.prefix(3), id: \.self) { numberOfCups in
                        DifficultyButton(
                            numberOfCups: numberOfCups,
                            isSelected: self.selectedNumberOfCups == numberOfCups
                        ) {
                            self.selectedNumberOfCups = numberOfCups
                        }
                    }
                }
                .padding(.horizontal)

                HStack(spacing: 20) {
                    ForEach(cupOptions.suffix(2), id: \.self) { numberOfCups in
                        DifficultyButton(
                            numberOfCups: numberOfCups,
                            isSelected: self.selectedNumberOfCups == numberOfCups
                        ) {
                            self.selectedNumberOfCups = numberOfCups
                        }
                    }
                }
                .padding(.horizontal)

                Button(action: {
                    selectRandomCups()
                }) {
                    Text("隨機選擇")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .frame(width: 150, height: 40)
                        .background(Color.clear)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                }
                .padding(.top, 20)

                Spacer()

                // --- 修改這裡的 NavigationLink ---
                NavigationLink(destination: BottleGameView(numberOfCups: selectedNumberOfCups ?? 6)) {
                    Text("開始遊戲")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(selectedNumberOfCups != nil ? Color.green : Color.gray)
                        .cornerRadius(15)
                }
                .disabled(selectedNumberOfCups == nil)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

// DifficultyButton 保持不變
struct DifficultyButton: View {
    let numberOfCups: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("\(numberOfCups)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(isSelected ? .white : .blue)
                .frame(width: 80, height: 80)
                .background(isSelected ? Color.blue : Color.blue.opacity(0.2))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 2)
                )
        }
    }
}

// 預覽
struct DifficultySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BottleChoose()
    }
}
