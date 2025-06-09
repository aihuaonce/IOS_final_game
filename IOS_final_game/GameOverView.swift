//
//   GameOverView.swift
//   IOS_final_game
//
//   Created by 11144137 on 2025/6/9.
//

import SwiftUI

struct GameOverView: View {
    @State private var showingThanksAlert = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                Text("遊戲結束")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 50)

                VStack(spacing: 20) {
                    // MARK: - 回到首頁按鈕 (使用 NavigationLink 包裹 Text 樣式)
                    NavigationLink {
                        ContentView()
                    } label: {
                        Text("回到首頁")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: 250)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }

                    // MARK: - 打賞鼓勵按鈕
                    Button {
                        showingThanksAlert = true
                    } label: {
                        Label("打賞鼓勵", systemImage: "heart.fill")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(Capsule().fill(Color.orange))
                            .foregroundColor(.white)
                    }
                    .alert("感謝您的打賞！", isPresented: $showingThanksAlert) {
                        Button("好的", role: .cancel) { }
                    } message: {
                        Text("您的支持是我們最大的動力！")
                    }
                }

                Spacer()
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameOverView()
        }
    }
}
