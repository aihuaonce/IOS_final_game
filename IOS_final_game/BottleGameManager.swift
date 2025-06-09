//
//  BottleGameManager.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import Foundation

struct GuessResult {
    let A: Int
    let B: Int
}

class GameManager: ObservableObject {
    @Published var secretSequence: [CupColor]
    @Published var playerSequence: [CupColor]

    private let numberOfValue: Int

    init(numberOfValue: Int) {
        self.numberOfValue = numberOfValue

        let availableColors = Array(CupColor.allCases.prefix(numberOfValue))
        
        guard availableColors.count >= numberOfValue else {
            fatalError("CupColor 的數量不足以支援選擇的難度 \(numberOfValue)")
        }

        let tempColors = availableColors.shuffled()
        self.secretSequence = Array(tempColors.prefix(numberOfValue))
        
        let initialPlayerColors = tempColors.shuffled() 
        self.playerSequence = Array(initialPlayerColors.prefix(numberOfValue))

        print("秘密序列 (位數: \(numberOfValue)): \(secretSequence.map { $0.rawValue })")
        print("玩家初始序列 (位數: \(numberOfValue)): \(playerSequence.map { $0.rawValue })")
    }

    func swapCups(index1: Int, index2: Int) {
        guard index1 >= 0 && index1 < playerSequence.count,
              index2 >= 0 && index2 < playerSequence.count,
              index1 != index2 else {
            print("無效的交換索引")
            return
        }
        playerSequence.swapAt(index1, index2)
        print("交換後玩家序列: \(playerSequence.map { $0.rawValue })")
    }

    func checkGuess() -> GuessResult {
        var aCount = 0
        var bCount = 0

        var secretTemp = secretSequence.map { $0.rawValue }
        var playerTemp = playerSequence.map { $0.rawValue }

        for i in 0..<playerSequence.count {
            if playerTemp[i] == secretTemp[i] {
                aCount += 1
                playerTemp[i] = "MATCHED_A"
                secretTemp[i] = "MATCHED_A"
            }
        }

        for i in 0..<playerSequence.count {
            if playerTemp[i] != "MATCHED_A" {
                if let secretIndex = secretTemp.firstIndex(of: playerTemp[i]) {
                    bCount += 1
                    secretTemp[secretIndex] = "MATCHED_B"
                }
            }
        }
        
        return GuessResult(A: aCount, B: bCount)
    }
}
