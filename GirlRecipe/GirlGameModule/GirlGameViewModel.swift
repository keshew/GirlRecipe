import SwiftUI

class GirlGameViewModel: ObservableObject {
    let contact = GirlGameModel()

    func createGirlGameScene(gameData: GirlGameData, level: Int) -> GirlGameSpriteKit {
        let scene = GirlGameSpriteKit(level: level)
        scene.game  = gameData
        return scene
    }
}
