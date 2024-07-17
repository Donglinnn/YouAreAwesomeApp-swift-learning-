//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Che-lun Hu on 2024/7/9.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var messageString = ""
    @State private var imageName = ""
    @State private var lastMessageNumber = -1
    @State private var lastImageNumber = -1
    @State private var lastSoundNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    @State private var soundIsOn = true
    
    var body: some View {
        VStack {
            Text(messageString)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.red)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding()
                .animation(.easeInOut(duration: 0.15), value: messageString)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
                .shadow(radius: 30)
                .padding()
                .animation(.default, value: messageString)
            
            Spacer()
            
            HStack {
                
                Text("Sound On:")
                Toggle("Sound On:", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) {
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }
                    }
                
                Spacer()
                
                Button("Show Message") {
                    var messages: [String] = ["You Are Awesome!",
                                              "You Are Great!",
                                              "You Are Fantastic!",
                                              "You Are a Code Monster!"]
                    messages.append("Fabulous? That's You!")
                    
                    
                    lastMessageNumber = nonRepeatingRandom(lastNumber: lastMessageNumber, upperBounds: messages.count - 1)
                    messageString = messages[lastMessageNumber]
                    
                    
                    lastImageNumber = nonRepeatingRandom(lastNumber: lastImageNumber, upperBounds: 9)
                    imageName = "image\(lastImageNumber)"
                    
                    
                    lastSoundNumber = nonRepeatingRandom(lastNumber: lastSoundNumber, upperBounds: 5)
                    if (soundIsOn) {
                        playsound(soundName: "sound\(lastSoundNumber)")
                    }
                }
                .buttonStyle(.borderedProminent)
                
            }
            .tint(.accentColor)
        }
        .padding()
    }
    
    func nonRepeatingRandom(lastNumber: Int, upperBounds: Int) -> Int {
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 0...upperBounds)
        } while newNumber == lastNumber
        return newNumber
    }
    
    func playsound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("🥲 Could not read file named \(soundName) 🥲")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("🥲 ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
}

#Preview {
    ContentView()
}

