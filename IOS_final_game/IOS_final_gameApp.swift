//
//  IOS_final_gameApp.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/2.
//

import SwiftUI
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer?

@main
struct IOS_final_gameApp: App {
    @AppStorage("musicVolume") var musicVolume: Double = 0.5

    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category. \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if backgroundMusicPlayer == nil {
                        playBackgroundMusic()
                    } else if backgroundMusicPlayer?.isPlaying == false {
                        backgroundMusicPlayer?.play()
                    }
                    updateBackgroundMusicVolume()
                }
                .onChange(of: musicVolume) { _, _ in
                    updateBackgroundMusicVolume()
                }
        }
    }

    func playBackgroundMusic() {
        print("playBackgroundMusic() 函數被調用")
        guard let url = Bundle.main.url(forResource: "backgroundmusic", withExtension: "mp3") else {
            print("背景音樂檔案 backgroundmusic.mp3 未找到")
            return
        }

        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            updateBackgroundMusicVolume() // 初始化時設定音量
            backgroundMusicPlayer?.play()
            print("背景音樂開始播放")
        } catch {
            print("無法初始化背景音樂播放器: \(error.localizedDescription)")
        }
    }

    func updateBackgroundMusicVolume() {
        backgroundMusicPlayer?.volume = Float(musicVolume)
        print("背景音樂音量更新為：\(backgroundMusicPlayer?.volume ?? -1)")
    }
}
