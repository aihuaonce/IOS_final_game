//
//  PeopleGame.swift
//  IOS_final_game
//
//  Created by 11144155 on 2025/6/9.
//

import SwiftUI
import SpriteKit

struct PeopleGame: View {
    @State private var showPeopleGameOverScreen: Bool = false
    var scene: SKScene {
        let scene = GameScene(
            size: UIScreen.main.bounds.size,
            showPeopleGameOverScreen: $showPeopleGameOverScreen)
        scene.scaleMode = .resizeFill
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
        if showPeopleGameOverScreen {
            GameOverView()
                .transition(.opacity)
        }
    }
}


