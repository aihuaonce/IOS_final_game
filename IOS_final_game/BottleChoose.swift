//
//  Bottle.swift
//  IOS_final_game
//
//  Created by 11144132 on 6/9/25.
//

import SwiftUI

struct BottleChoose: View {
    var body: some View {
        VStack {
            Text("瓶子遊戲")
                .font(.largeTitle)
                .padding(.bottom, 30)

            Text("請選擇難度：")
                .font(.headline)
                .padding(.bottom, 20)

            // 難度按鈕範例
            Button("簡單") {
                // TODO: 進入瓶子遊戲的簡單模式
                print("進入瓶子遊戲 - 簡單模式")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 10)

            Button("中等") {
                // TODO: 進入瓶子遊戲的中等模式
                print("進入瓶子遊戲 - 中等模式")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 10)

            Button("困難") {
                // TODO: 進入瓶子遊戲的困難模式
                print("進入瓶子遊戲 - 困難模式")
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("瓶子遊戲難度")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BottleChoose_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BottleChoose()
        }
    }
}
