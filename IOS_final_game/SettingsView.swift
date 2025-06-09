//
//  SettingsView.swift
//  IOS_final_game
//
//  Created by 11144132 on 6/9/25.
//


import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("musicVolume") var musicVolume: Double = 0.5
    @AppStorage("soundVolume") var soundVolume: Double = 0.7

    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            VStack {
                Text("OPTIONS")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                Spacer()
                VStack(alignment: .leading) {
                    Text("MUSIC")
                        .font(.headline)
                        .padding(.leading)
                    HStack {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.gray)
                            .onTapGesture { musicVolume = max(0.0, musicVolume - 0.1) }
                        Slider(value: $musicVolume, in: 0...1, step: 0.05) {
                            Text("Music Volume")
                        }
                        .tint(.green)
                        .padding(.horizontal)
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)
                            .onTapGesture { musicVolume = min(1.0, musicVolume + 0.1) }

                        Text("\(Int(musicVolume * 100))%")
                            .font(.subheadline)
                            .frame(width: 50, alignment: .trailing)
                    }
                }
                .padding().background(RoundedRectangle(cornerRadius: 15).fill(Color.orange.opacity(0.2)).stroke(Color.brown, lineWidth: 3)).padding(.horizontal, 30).padding(.bottom, 30)

                VStack(alignment: .leading) {
                    Text("SOUND")
                        .font(.headline)
                        .padding(.leading)
                    HStack {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.gray)
                            .onTapGesture { soundVolume = max(0.0, soundVolume - 0.1) }
                        Slider(value: $soundVolume, in: 0...1, step: 0.05) {
                            Text("Sound Volume")
                        }
                        .tint(.green)
                        .padding(.horizontal)
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)
                            .onTapGesture { soundVolume = min(1.0, soundVolume + 0.1) }

                        Text("\(Int(soundVolume * 100))%")
                            .font(.subheadline)
                            .frame(width: 50, alignment: .trailing)
                    }
                }
                .padding().background(RoundedRectangle(cornerRadius: 15).fill(Color.orange.opacity(0.2)).stroke(Color.brown, lineWidth: 3)).padding(.horizontal, 30).padding(.bottom, 50)
                Spacer()
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }.padding(.bottom, 20)
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
