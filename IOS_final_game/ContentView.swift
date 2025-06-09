//
//  ContentView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/2.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showSettings = false
    @State private var soundEffectPlayer: AVAudioPlayer?

    @AppStorage("soundVolume") var soundVolume: Double = 0.7

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("...遊戲")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.bottom, 50)

                // 瓶子按鈕
                NavigationLink(destination: Text("瓶子遊戲難度選擇頁面")) {
                    Text("瓶子")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 80)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    print("點擊了瓶子！")
                    playSoundEffect(soundFileName: "sound", fileExtension: "mp3")
                })
                .padding(.bottom, 20)

                // 房子按鈕
                NavigationLink(destination: Text("房子遊戲難度選擇頁面")) {
                    Text("房子")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 80)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    print("點擊了房子！")
                    playSoundEffect(soundFileName: "sound", fileExtension: "mp3")
                })

                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("點擊了空白區域！")
                playSoundEffect(soundFileName: "sound", fileExtension: "mp3")
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings = true
                        print("點擊了設定按鈕！")
                        playSoundEffect(soundFileName: "sound", fileExtension: "mp3")
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .onChange(of: soundVolume) { _, newVolume in
            soundEffectPlayer?.volume = Float(newVolume)
        }
    }

    func playSoundEffect(soundFileName: String, fileExtension: String) {
        print("playSoundEffect() 嘗試播放 \(soundFileName).\(fileExtension)")
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: fileExtension) else {
            print("音效檔案 \(soundFileName).\(fileExtension) 未找到")
            return
        }

        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
            soundEffectPlayer?.volume = Float(soundVolume)
            soundEffectPlayer?.play()
            print("音效 \(soundFileName) 播放中，音量：\(soundEffectPlayer?.volume ?? -1)")
        } catch {
            print("無法初始化音效播放器: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
