//
//  People.swift
//  IOS_final_game
//
//  Created by 11144132 on 6/9/25.
//
import SwiftUI

struct PeopleChoose: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("選擇難度")
                    .font(.largeTitle)
                    .bold()
                
                ForEach(PeopleGameDifficulty.allCases, id: \.self) { difficulty in
                    NavigationLink(destination:
                                    PeopleTimeChoose()
                        .onAppear {
                            GameSettings.shared.difficulty = difficulty
                        }
                    ) {
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
                    .navigationBarBackButtonHidden(true)
            }
            .padding()
        }
    }
}

// ✅ 改名後的 enum
enum PeopleGameDifficulty: String, CaseIterable {
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


#Preview {
    PeopleChoose()
}
