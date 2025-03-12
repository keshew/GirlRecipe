import SwiftUI
import SpriteKit

extension GirlGameSpriteKit {
    func createTappedView() {
        let pause = SKSpriteNode(imageNamed: GirlImageName.pause.rawValue)
        pause.name = "pause"
        pause.size = CGSize(width: size.width * 0.1875, height: size.width * 0.2125)
        pause.position = CGPoint(x: size.width / 8, y: size.height / 1.13)
        addChild(pause)
        
        let rules = SKSpriteNode(imageNamed: GirlImageName.rules.rawValue)
        rules.name = "rules"
        rules.size = CGSize(width: size.width * 0.1875, height: size.width * 0.2125)
        rules.position = CGPoint(x: size.width / 1.15, y: size.height / 1.13)
        addChild(rules)
    }
    
    func createMainView() {
        let gameBackground = SKSpriteNode(imageNamed: GirlImageName.mainBackground.rawValue)
        gameBackground.size = CGSize(width: size.width, height: size.height)
        gameBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameBackground)
        
        let topShadow = SKSpriteNode(imageNamed: GirlImageName.topShadow.rawValue)
        topShadow.size = CGSize(width: size.width, height: size.height / 3)
        topShadow.position = CGPoint(x: size.width / 2, y: size.height / 1.2)
        addChild(topShadow)
        
        let bottomShadow = SKSpriteNode(imageNamed: GirlImageName.bottomShadow.rawValue)
        bottomShadow.size = CGSize(width: size.width, height: size.height / 3)
        bottomShadow.position = CGPoint(x: size.width / 2, y: size.height / 6)
        addChild(bottomShadow)
        
        let backForCoin = SKSpriteNode(imageNamed: GirlImageName.backForBudget.rawValue)
        backForCoin.size = CGSize(width: size.width * 0.425, height: size.height * 0.073)
        backForCoin.position = CGPoint(x: size.width / 4, y: size.height / 1.3)
        addChild(backForCoin)
        
        let coin = SKSpriteNode(imageNamed: GirlImageName.coin.rawValue)
        coin.size = CGSize(width: size.width * 0.204, height: size.width * 0.204)
        coin.position = CGPoint(x: size.width / 8, y: size.height / 1.3)
        addChild(coin)
        
        let backForLives = SKSpriteNode(imageNamed: GirlImageName.backForBudget.rawValue)
        backForLives.size = CGSize(width: size.width * 0.425, height: size.height * 0.073)
        backForLives.position = CGPoint(x: size.width / 1.35, y: size.height / 1.3)
        addChild(backForLives)
        
        let heart = SKSpriteNode(imageNamed: GirlImageName.heart.rawValue)
        heart.size = CGSize(width: size.width * 0.23, height: size.width * 0.23)
        heart.position = CGPoint(x: size.width / 1.7, y: size.height / 1.3)
        addChild(heart)
        
        let desk = SKSpriteNode(imageNamed: GirlImageName.settingsBack.rawValue)
        desk.size = CGSize(width: size.width * 0.9, height: size.height * 0.38)
        desk.position = CGPoint(x: size.width / 2, y: size.height / 2.07)
        addChild(desk)
        
        let elementsLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        elementsLabel.attributedText = NSAttributedString(string: "ELEMENTS", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3
        ])
        elementsLabel.position = CGPoint(x: size.width / 2, y: size.height / 3.8)
        addChild(elementsLabel)
        
        let backForElements = SKSpriteNode(imageNamed: GirlImageName.gameBack.rawValue)
        backForElements.size = CGSize(width: size.width * 0.9, height: size.height * 0.095)
        backForElements.position = CGPoint(x: size.width / 2, y: size.height / 4.8)
        addChild(backForElements)
        
        let mistakesLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        mistakesLabel.attributedText = NSAttributedString(string: "MISTAKES", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3
        ])
        mistakesLabel.position = CGPoint(x: size.width / 2, y: size.height / 7.7)
        addChild(mistakesLabel)
        
        let backForMistake = SKSpriteNode(imageNamed: GirlImageName.gameBack.rawValue)
        backForMistake.size = CGSize(width: size.width * 0.476, height: size.height * 0.07)
        backForMistake.position = CGPoint(x: size.width / 2, y: size.height / 11)
        addChild(backForMistake)
        
        let bonusMistake = SKSpriteNode(imageNamed: GirlImageName.bonusMistakeGame.rawValue)
        bonusMistake.name = "bonusMistake"
        bonusMistake.size = CGSize(width: size.width * 0.187, height: size.width * 0.179)
        bonusMistake.position = CGPoint(x: size.width / 7, y: size.height / 11)
        addChild(bonusMistake)
        
        let bonusTime = SKSpriteNode(imageNamed: GirlImageName.bonusTimeGame.rawValue)
        bonusTime.name = "bonusTime"
        bonusTime.size = CGSize(width: size.width * 0.187, height: size.width * 0.179)
        bonusTime.position = CGPoint(x: size.width / 1.2, y: size.height / 11)
        addChild(bonusTime)
        
        mistakesBonusCountLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        mistakesBonusCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.integer(forKey: Keys.mistakeCount.rawValue))", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3
        ])
        mistakesBonusCountLabel.position = CGPoint(x: size.width / 5.05, y: size.height / 17.1)
        addChild(mistakesBonusCountLabel)
        
        timeBonusCountLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        timeBonusCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.integer(forKey: Keys.timeCount.rawValue))", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3
        ])
        timeBonusCountLabel.position = CGPoint(x: size.width / 1.285, y: size.height / 16.8)
        addChild(timeBonusCountLabel)
        
        let bonusLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        bonusLabel.attributedText = NSAttributedString(string: "BONUS", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3
        ])
        bonusLabel.position = CGPoint(x: size.width / 7.1, y: size.height / 28)
        addChild(bonusLabel)
        
        let bonusMistakesLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        bonusMistakesLabel.attributedText = NSAttributedString(string: "MISTAKES", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3
        ])
        bonusMistakesLabel.position = CGPoint(x: size.width / 7.1, y: size.height / 50)
        addChild(bonusMistakesLabel)
        
        let bonusTimeLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        bonusTimeLabel.attributedText = NSAttributedString(string: "BONUS", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3
        ])
        bonusTimeLabel.position = CGPoint(x: size.width / 1.19, y: size.height / 28)
        addChild(bonusTimeLabel)
        
        let bonusTimeLabll = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        bonusTimeLabll.attributedText = NSAttributedString(string: "TIME", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3
        ])
        bonusTimeLabll.position = CGPoint(x: size.width / 1.19, y: size.height / 50)
        addChild(bonusTimeLabll)
        }

    
    func createMutatingView() {
        let levelLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        levelLabel.attributedText = NSAttributedString(string: "LEVEL \(level)", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 40)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        levelLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.22)
        addChild(levelLabel)
        
        let coinLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        coinLabel.attributedText = NSAttributedString(string: "COINS", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        coinLabel.position = CGPoint(x: size.width / 3.25, y: size.height / 1.31)
        addChild(coinLabel)
        
        let coinCountLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        coinCountLabel.attributedText = NSAttributedString(string: ":\(UserDefaultsManager.defaults.integer(forKey: Keys.money.rawValue))", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        coinCountLabel.position = CGPoint(x: size.width / 3.25, y: size.height / 1.345)
        addChild(coinCountLabel)
        
        let livesLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        livesLabel.attributedText = NSAttributedString(string: "LIVES", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        livesLabel.position = CGPoint(x: size.width / 1.28, y: size.height / 1.31)
        addChild(livesLabel)
        
        let livesCountLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        livesCountLabel.attributedText = NSAttributedString(string: ":\(UserDefaultsManager.defaults.integer(forKey: Keys.lifes.rawValue))", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        livesCountLabel.position = CGPoint(x: size.width / 1.28, y: size.height / 1.345)
        addChild(livesCountLabel)
        
        let timeLeftLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        timeLeftLabel.attributedText = NSAttributedString(string: "TIME", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        timeLeftLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.42)
        addChild(timeLeftLabel)
        
        let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 595, width: 380, height: 16), cornerRadius: 8)
        let shapeNode = SKShapeNode(path: path.cgPath)
        shapeNode.lineWidth = 0
        shapeNode.fillColor = SKColor.black
        shapeNode.alpha = 0.6
        addChild(shapeNode)
    }
    
}
