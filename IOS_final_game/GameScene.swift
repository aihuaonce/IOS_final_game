//
//  GameScene.swift
//  IOS_final_game
//
//  Created by 11144155 on 2025/6/9.
//
//
//  GameScene.swift
//  IOS_final_game
//
//  Created by 11144155 on 2025/6/9.
//

import SpriteKit
import GameplayKit

// ✅ Singleton with difficulty & time
class GameSettings {
    static let shared = GameSettings()

    var difficulty: PeopleGameDifficulty = .easy
    var gameTime: Int = 30

    private init() {}
}

// ✅ 遊戲邏輯使用的難度等級
enum DifficultyLevel: String {
    case easy, medium, hard

    var spawnInterval: TimeInterval {
        switch self {
        case .easy: return 2.5
        case .medium: return 1.8
        case .hard: return 0.8
        }
    }

    var moveDuration: TimeInterval {
        switch self {
        case .easy: return 4.5
        case .medium: return 2.8
        case .hard: return 1.8
        }
    }
}

class GameScene: SKScene {
    private var houseNode: SKLabelNode!
    private var timerLabel: SKLabelNode!
    private var peopleCounter = 0
    private var gameTime = 30
    private var difficulty: DifficultyLevel = .easy
    private var timer: Timer?
    private var spawnTimer: Timer?
    private var inputNumber = 0
    private var inputLabel: SKLabelNode!
    private var submitButton: SKLabelNode!
    private var plusButton: SKLabelNode!
    private var minusButton: SKLabelNode!
    private var gameEnded = false

    override func didMove(to view: SKView) {
        backgroundColor = .white

        if let diff = DifficultyLevel(rawValue: GameSettings.shared.difficulty.rawValue) {
            self.difficulty = diff
        }
        self.gameTime = GameSettings.shared.gameTime

        setupUI()
        startGame()
    }

    private func setupUI() {
        houseNode = SKLabelNode(text: "🏠")
        houseNode.fontSize = 50
        houseNode.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        addChild(houseNode)

        timerLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        timerLabel.fontSize = 28
        timerLabel.fontColor = .black
        timerLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        timerLabel.text = "Time: \(gameTime)"
        addChild(timerLabel)

        inputLabel = SKLabelNode(fontNamed: "Courier")
        inputLabel.fontSize = 32
        inputLabel.fontColor = .black
        inputLabel.text = "0"
        inputLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.25)
        addChild(inputLabel)

        plusButton = SKLabelNode(text: "+")
        plusButton.fontSize = 36
        plusButton.fontColor = .green
        plusButton.position = CGPoint(x: inputLabel.position.x + 80, y: inputLabel.position.y)
        plusButton.name = "plus"
        addChild(plusButton)

        minusButton = SKLabelNode(text: "-")
        minusButton.fontSize = 36
        minusButton.fontColor = .red
        minusButton.position = CGPoint(x: inputLabel.position.x - 80, y: inputLabel.position.y)
        minusButton.name = "minus"
        addChild(minusButton)

        submitButton = SKLabelNode(text: "提交")
        submitButton.fontSize = 28
        submitButton.fontColor = .blue
        submitButton.position = CGPoint(x: size.width / 2, y: inputLabel.position.y - 80)
        submitButton.name = "submit"
        submitButton.isHidden = true
        addChild(submitButton)
    }

    private func startGame() {
        timerLabel.text = "Time: \(gameTime)"
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.gameTime -= 1
            self.timerLabel.text = "Time: \(self.gameTime)"
            if self.gameTime <= 0 {
                self.timer?.invalidate()
                self.spawnTimer?.invalidate()
                self.submitButton.isHidden = false
            }
        }

        spawnTimer = Timer.scheduledTimer(withTimeInterval: difficulty.spawnInterval, repeats: true) { _ in
            self.spawnCharacters()
        }
    }

    private func spawnCharacters() {
        let types = ["🐱", "🐶", "👨", "👩"]
        let count = Int.random(in: 1...3)
        var usedFrames: [CGRect] = []

        for _ in 0..<count {
            let emoji = types.randomElement()!
            let label = SKLabelNode(text: emoji)
            label.fontSize = 36
            label.name = emoji

            var position: CGPoint
            var attempts = 0
            repeat {
                let x = CGFloat.random(in: 30...(size.width - 30))
                let y = CGFloat.random(in: size.height / 2...(size.height - 80))
                position = CGPoint(x: x, y: y)
                attempts += 1
            } while (
                usedFrames.contains(where: { $0.contains(position) }) ||
                distance(from: position, to: houseNode.position) < 100
            ) && attempts < 20

            label.position = position
            usedFrames.append(label.frame)
            addChild(label)

            let move = SKAction.move(to: houseNode.position, duration: difficulty.moveDuration)
            let countAction = SKAction.run {
                if emoji == "👨" || emoji == "👩" {
                    self.peopleCounter += 1
                }
            }
            let remove = SKAction.removeFromParent()
            label.run(SKAction.sequence([move, countAction, remove]))
        }
    }

    private func endGameCheck() {
        gameEnded = true

        let result = (inputNumber == peopleCounter) ? "✅ 答對" : "❌ 答錯"
        let resultLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        resultLabel.text = result
        resultLabel.fontSize = 36
        resultLabel.fontColor = .black
        resultLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(resultLabel)

        for _ in 0..<peopleCounter {
            let emoji = ["👨", "👩"].randomElement()!
            let sprite = SKLabelNode(text: emoji)
            sprite.fontSize = 36
            sprite.position = houseNode.position
            addChild(sprite)

            let angle = CGFloat.random(in: 0...CGFloat.pi * 2)
            let dx = cos(angle) * 100
            let dy = sin(angle) * 100
            let move = SKAction.moveBy(x: dx, y: dy, duration: 3)
            let remove = SKAction.removeFromParent()
            sprite.run(SKAction.sequence([move, remove]))
        }

        peopleCounter = 0
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let tappedNodes = nodes(at: location)

        for node in tappedNodes {
            switch node.name {
            case "plus":
                inputNumber += 1
                inputLabel.text = "\(inputNumber)"
            case "minus":
                inputNumber = max(0, inputNumber - 1)
                inputLabel.text = "\(inputNumber)"
            case "submit":
                if !gameEnded {
                    endGameCheck()
                }
            default:
                break
            }
        }
    }

    // ✅ 加入距離計算
    private func distance(from: CGPoint, to: CGPoint) -> CGFloat {
        return hypot(from.x - to.x, from.y - to.y)
    }
}
