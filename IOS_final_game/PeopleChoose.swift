//
//  People.swift
//  IOS_final_game
//
//  Created by 11144132 on 6/9/25.
//

//
//  People.swift
//  IOS_final_game
//
//  Created by 11144132 on 6/9/25.
//

import SwiftUI

struct PeopleChoose: View {
    // 用於儲存目前選擇的難度
    @State private var selectedDifficulty: Difficulty?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("選擇難度")
                    .font(.largeTitle)
                    .bold()

                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    Button(action: {
                        selectedDifficulty = difficulty
                        print("選擇了：\(difficulty.rawValue)")
                        // 在這裡觸發下一步的邏輯，例如導向遊戲頁面
                    }) {
                        Text(difficulty.displayName)
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(difficulty.color)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
        }
    }
}

// 難度列舉
enum Difficulty: String, CaseIterable {
    case easy
    case medium
    case hard

    var displayName: String {
        switch self {
        case .easy: return "菜就多練"
        case .medium: return "危"
        case .hard: return "死"
        }
    }

    var color: Color {
        switch self {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
}

// 預覽
struct PeopleChoose_Previews: PreviewProvider {
    static var previews: some View {
        PeopleChoose()
    }
}
