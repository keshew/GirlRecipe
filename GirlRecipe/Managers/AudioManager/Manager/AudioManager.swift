import AVFoundation
import SwiftUI

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    var losePlayer: AVAudioPlayer?
    var winPlayer: AVAudioPlayer?
    var bgPlayer: AVAudioPlayer?
    
    @Published var backgroundVolume: Float {
        didSet {
            losePlayer?.volume = backgroundVolume
            winPlayer?.volume = backgroundVolume
            bgPlayer?.volume = backgroundVolume
        }
    }
    
    @Published var soundEffectVolume: Float {
        didSet {
            
        }
    }
    
    init() {
        self.backgroundVolume = UserDefaultsManager().loadVolumeSettings().0
        self.soundEffectVolume = UserDefaultsManager().loadVolumeSettings().1
        loadWinMusic()
        loadLoseMusic()
        loadBackgroundMusic()
    }

    private func loadLoseMusic() {
        if let url = Bundle.main.url(forResource: "lose", withExtension: "wav") {
            do {
                losePlayer = try AVAudioPlayer(contentsOf: url)
                losePlayer?.numberOfLoops = -1
                losePlayer?.volume = backgroundVolume
                losePlayer?.prepareToPlay()
            } catch {
                print("Ошибка \(error)")
            }
        }
    }
    
    private func loadWinMusic() {
        if let url = Bundle.main.url(forResource: "win", withExtension: "wav") {
            do {
                winPlayer = try AVAudioPlayer(contentsOf: url)
                winPlayer?.numberOfLoops = -1
                winPlayer?.volume = backgroundVolume
                winPlayer?.prepareToPlay()
            } catch {
                print("Ошибка \(error)")
            }
        }
    }
    
    private func loadBackgroundMusic() {
        if let url = Bundle.main.url(forResource: "bg", withExtension: "wav") {
            do {
                bgPlayer = try AVAudioPlayer(contentsOf: url)
                bgPlayer?.numberOfLoops = -1
                bgPlayer?.volume = backgroundVolume
                bgPlayer?.prepareToPlay()
            } catch {
                print("Ошибка \(error)")
            }
        }
    }
    func playLoseMusic() {
        losePlayer?.play()
    }
    
    func stopLoseMusic() {
        losePlayer?.stop()
    }
    
    func playWinMusic() {
        winPlayer?.play()
    }
    
    func stopWinMusic() {
        winPlayer?.stop()
    }
    
    func playBackgroundMusic() {
        bgPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        bgPlayer?.stop()
    }
}
