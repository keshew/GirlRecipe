import SwiftUI
import SpriteKit

class GirlGameData: ObservableObject {
    @Published var isPause = false
    @Published var isMenu = false
    @Published var isWin = false
    @Published var isLose = false
    @Published var isRules = false
    @Published var timeLeft = 120
    @Published var mistakes = 0
    @Published var scene = SKScene()
}

class GirlGameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: GirlGameData?
    var movableNode: SKSpriteNode?
    var shadowFruit: SKSpriteNode!
    var shadowCircle: SKSpriteNode!
    var shadowFruit2: SKSpriteNode!
    var shadowCircle2: SKSpriteNode!
    var shadowFruit3: SKSpriteNode!
    var shadowCircle3: SKSpriteNode!
    var shadowFruit4: SKSpriteNode!
    var shadowCircle4: SKSpriteNode!
    var mistakeNodes: [SKSpriteNode] = []
    var level: Int
    var currentSet = 1
    var completedSets = 0
    var completedFirstSet = false
    var shadowElement: SKSpriteNode!
    var shadowElement2: SKSpriteNode!
    var shadowElement3: SKSpriteNode!
    var shadowElement4: SKSpriteNode!
    var placedNodes = [SKSpriteNode]()
    var selectedShadowPart: SKSpriteNode!
    var progressBarNode: SKShapeNode!
    var mistakesBonusCountLabel: SKLabelNode!
    var timeBonusCountLabel: SKLabelNode!
    
    init(level: Int) {
        self.level = level
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nodeShadowMap: [String: String] = [
        "fruit1": "shadowFruit7",
        "fruit2": "shadowFruit3",
        "fruit3": "shadowFruit4",
        "fruit4": "shadowFruit11",
        "fruit5": "shadowFruit8",
        "circle2": "shadowCircle9",
        "circle3": "shadowCircle5",
        "circle4": "shadowCircle10",
        "circle5": "shadowCircle1",
        "circle6": "shadowCircle2"
    ]
    
    func tapOnPause(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "pause" {
            game!.isPause = true
            game!.scene = scene!
            scene?.isPaused = true
        }
    }
    
    func tapOnRules(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "rules" {
            game!.isRules = true
            game!.scene = scene!
            scene?.isPaused = true
        }
    }
    
    func tapOnMistakeBonus(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "bonusMistake" {
            if UserDefaultsManager.defaults.integer(forKey: Keys.mistakeCount.rawValue) != 0 {
                game!.mistakes -= 1
                updateMistakeNodes()
                UserDefaultsManager().useBonus(key: Keys.mistakeCount.rawValue)
                
                mistakesBonusCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.integer(forKey: Keys.mistakeCount.rawValue))", attributes: [
                    NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 15)!,
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
                    NSAttributedString.Key.strokeWidth: -3
                ])
            }
        }
    }
    
    func tapOnTimeBonus(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "bonusTime" {
            if UserDefaultsManager.defaults.integer(forKey: Keys.timeCount.rawValue) != 0 {
                progressBarNode.removeFromParent()
                createProgress()
                
                UserDefaultsManager().useBonus(key: Keys.timeCount.rawValue)
                
                timeBonusCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.integer(forKey: Keys.timeCount.rawValue))", attributes: [
                    NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 15)!,
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.strokeColor: UIColor(red: 169/255, green: 2/255, blue: 146/255, alpha: 1),
                    NSAttributedString.Key.strokeWidth: -3
                ])
            }
        }
    }
    
    func updateMistakeNodes() {
        if level < 4 {
            for i in 0..<5 {
                if i < game!.mistakes {
                    mistakeNodes[i].texture = SKTexture(imageNamed: GirlImageName.mistake1.rawValue)
                } else {
                    mistakeNodes[i].texture = SKTexture(imageNamed: GirlImageName.mistake2.rawValue)
                }
            }
            
            if game!.mistakes == 5 {
                game!.isLose = true
            }
        } else if level >= 4, level <= 7 {
            for i in 0..<4 {
                if i < game!.mistakes {
                    mistakeNodes[i].texture = SKTexture(imageNamed: GirlImageName.mistake1.rawValue)
                } else {
                    mistakeNodes[i].texture = SKTexture(imageNamed: GirlImageName.mistake2.rawValue)
                }
            }
            
            if game!.mistakes == 4 {
                game!.isLose = true
            }
        } else if level > 7 {
            for i in 0..<3 {
                if i < game!.mistakes {
                    mistakeNodes[i].texture = SKTexture(imageNamed: GirlImageName.mistake1.rawValue)
                } else {
                    mistakeNodes[i].texture = SKTexture(imageNamed: GirlImageName.mistake2.rawValue)
                }
            }
            
            if game!.mistakes == 3 {
                game!.isLose = true
            }
        }
    }
    
    func createMistake() {
        if level < 4 {
            for i in 0..<5 {
                let mistake = SKSpriteNode(imageNamed: GirlImageName.mistake2.rawValue)
                mistake.size = CGSize(width: size.width * 0.07, height: size.width * 0.063)
                mistake.position = CGPoint(x: size.width / 1.53 + CGFloat((CGFloat(i) * (size.width * -0.078))), y: size.height / 11.2)
                addChild(mistake)
                mistakeNodes.append(mistake)
            }
        } else if level >= 4, level <= 7 {
            for i in 0..<4 {
                let mistake = SKSpriteNode(imageNamed: GirlImageName.mistake2.rawValue)
                mistake.size = CGSize(width: size.width * 0.07, height: size.width * 0.063)
                mistake.position = CGPoint(x: size.width / 1.57 + CGFloat((CGFloat(i) * (size.width * -0.09))), y: size.height / 11.2)
                addChild(mistake)
                mistakeNodes.append(mistake)
            }
        } else if level > 7 {
            for i in 0..<3 {
                let mistake = SKSpriteNode(imageNamed: GirlImageName.mistake2.rawValue)
                mistake.size = CGSize(width: size.width * 0.07, height: size.width * 0.063)
                mistake.position = CGPoint(x: size.width / 1.65 + CGFloat((CGFloat(i) * (size.width * -0.11))), y: size.height / 11.2)
                addChild(mistake)
                mistakeNodes.append(mistake)
            }
        }
    }
    
    func returnAllElementImage() -> [String] {
        return [GirlImageName.element1.rawValue,
                GirlImageName.element2.rawValue,
                GirlImageName.element3.rawValue,
                GirlImageName.element4.rawValue,
                GirlImageName.element5.rawValue,
                GirlImageName.element6.rawValue,]
    }
    
    func returnAllCircleImage() -> [String] {
        return [GirlImageName.circle1.rawValue,
                GirlImageName.circle2.rawValue,
                GirlImageName.circle3.rawValue,
                GirlImageName.circle4.rawValue,
                GirlImageName.circle5.rawValue,
                GirlImageName.circle6.rawValue,]
    }
    
    func returnAllFruitImage() -> [String] {
        return [GirlImageName.fruit4.rawValue,
                GirlImageName.fruit5.rawValue,
                GirlImageName.fruit6.rawValue,
                GirlImageName.fruit1.rawValue,
                GirlImageName.fruit3.rawValue,
                GirlImageName.fruit2.rawValue]
    }
    
    func createFruit() {
        for i in 0..<6 {
            let element = SKSpriteNode(imageNamed: returnAllFruitImage()[i])
            element.size = CGSize(width: size.width * 0.1, height: size.width * 0.1125)
            element.name = "\(returnAllFruitImage()[i])"
            element.position = CGPoint(x: size.width / 1.2 +  CGFloat((CGFloat(i) * (size.width * -0.133))), y: size.height / 4.85)
            addChild(element)
        }
    }
    
    func createElement() {
        for i in 0..<6 {
            let element = SKSpriteNode(imageNamed: returnAllElementImage()[i])
            element.size = CGSize(width: size.width * 0.13, height: size.width * 0.092)
            element.name = "element\(i)"
            element.position = CGPoint(x: size.width / 1.2 + CGFloat((CGFloat(i) * (size.width * -0.133))), y: size.height / 4.85)
            addChild(element)
        }
    }
    
    func createCircle() {
        for i in 0..<6 {
            let element = SKSpriteNode(imageNamed: returnAllCircleImage()[i])
            element.size = CGSize(width: size.width * 0.12, height: size.width * 0.117)
            element.name = "\(returnAllCircleImage()[i])"
            element.position = CGPoint(x: size.width / 1.2 + CGFloat((i * (-53))), y: size.height / 4.85)
            addChild(element)
        }
    }
    
    func createShadow() {
        switch level {
        case 1:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.207, height: size.width * 0.254)
            shadowFruit.name = "shadowFruit4"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 3.5, y: size.height / 1.85)
            addChild(shadowFruit)
            
            let shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.565, height: size.width * 0.39)
            shadowElement.position = CGPoint(x: size.width / 2, y: size.height / 2.3)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow10.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.227, height: size.width * 0.236)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle10"
            shadowCircle.position = CGPoint(x: size.width / 1.5, y: size.height / 2.1)
            addChild(shadowCircle)
            
        case 2:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow3.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.207, height: size.width * 0.254)
            shadowFruit.name = "shadowFruit3"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 3.5, y: size.height / 1.85)
            addChild(shadowFruit)
            
            let shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.565, height: size.width * 0.39)
            shadowElement.position = CGPoint(x: size.width / 2, y: size.height / 2.3)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow1.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.227, height: size.width * 0.236)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle1"
            shadowCircle.position = CGPoint(x: size.width / 1.5, y: size.height / 2.1)
            addChild(shadowCircle)
            
        case 3:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.207, height: size.width * 0.254)
            shadowFruit.name = "shadowFruit7"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 3.5, y: size.height / 1.85)
            addChild(shadowFruit)
            
            let shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.565, height: size.width * 0.39)
            shadowElement.position = CGPoint(x: size.width / 2, y: size.height / 2.3)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow5.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.227, height: size.width * 0.236)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle5"
            shadowCircle.position = CGPoint(x: size.width / 1.5, y: size.height / 2.1)
            addChild(shadowCircle)
            
        case 4:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.11, height: size.width * 0.15)
            shadowFruit.name = "shadowFruit7"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 2.5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.221)
            shadowElement.position = CGPoint(x: size.width / 2, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow5.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.115)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle5"
            shadowCircle.position = CGPoint(x: size.width / 1.7, y: size.height / 1.75)
            addChild(shadowCircle)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.82, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.selectedShadowPart.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.83, height: size.width * 0.383)
            selectedShadowPart.position = CGPoint(x: size.width / 2, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow8.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.11, height: size.width * 0.15)
            shadowFruit2.name = "shadowFruit8"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 2.5, y: size.height / 2.35)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.221)
            shadowElement2.position = CGPoint(x: size.width / 2, y: size.height / 2.67)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow1.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.115)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle1"
            shadowCircle2.position = CGPoint(x: size.width / 1.7, y: size.height / 2.53)
            addChild(shadowCircle2)
            
        case 5:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow11.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.11, height: size.width * 0.15)
            shadowFruit.name = "shadowFruit11"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 2.5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.221)
            shadowElement.position = CGPoint(x: size.width / 2, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow1.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.115)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle1"
            shadowCircle.position = CGPoint(x: size.width / 1.7, y: size.height / 1.75)
            addChild(shadowCircle)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.82, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.selectedShadowPart.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.83, height: size.width * 0.383)
            selectedShadowPart.position = CGPoint(x: size.width / 2, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow3.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.11, height: size.width * 0.15)
            shadowFruit2.name = "shadowFruit3"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 2.5, y: size.height / 2.35)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.221)
            shadowElement2.position = CGPoint(x: size.width / 2, y: size.height / 2.67)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow2.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.115)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle2"
            shadowCircle2.position = CGPoint(x: size.width / 1.7, y: size.height / 2.53)
            addChild(shadowCircle2)
            
        case 6:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.11, height: size.width * 0.15)
            shadowFruit.name = "shadowFruit4"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 2.5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.221)
            shadowElement.position = CGPoint(x: size.width / 2, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow10.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.115)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle10"
            shadowCircle.position = CGPoint(x: size.width / 1.7, y: size.height / 1.75)
            addChild(shadowCircle)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.82, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.selectedShadowPart.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.83, height: size.width * 0.383)
            selectedShadowPart.position = CGPoint(x: size.width / 2, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.11, height: size.width * 0.15)
            shadowFruit2.name = "shadowFruit7"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 2.5, y: size.height / 2.35)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.221)
            shadowElement2.position = CGPoint(x: size.width / 2, y: size.height / 2.67)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow9.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.115)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle9"
            shadowCircle2.position = CGPoint(x: size.width / 1.7, y: size.height / 2.53)
            addChild(shadowCircle2)
            
        case 7:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.11, height: size.width * 0.15)
            shadowFruit.name = "shadowFruit7"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 2.5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.221)
            shadowElement.position = CGPoint(x: size.width / 2, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow2.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.115)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle2"
            shadowCircle.position = CGPoint(x: size.width / 1.7, y: size.height / 1.75)
            addChild(shadowCircle)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.82, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.selectedShadowPart.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.83, height: size.width * 0.383)
            selectedShadowPart.position = CGPoint(x: size.width / 2, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.11, height: size.width * 0.15)
            shadowFruit2.name = "shadowFruit4"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 2.5, y: size.height / 2.35)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.221)
            shadowElement2.position = CGPoint(x: size.width / 2, y: size.height / 2.67)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow9.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.115)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle9"
            shadowCircle2.position = CGPoint(x: size.width / 1.7, y: size.height / 2.53)
            addChild(shadowCircle2)
       
        case 8:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit.name = "shadowFruit7"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement.position = CGPoint(x: size.width / 3.4, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.ltShadow.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.41, height: size.width * 0.38)
            selectedShadowPart.position = CGPoint(x: size.width / 3.4, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow2.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle2"
            shadowCircle.position = CGPoint(x: size.width / 2.5, y: size.height / 1.75)
            addChild(shadowCircle)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow11.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit2.name = "shadowFruit11"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 1.65, y: size.height / 1.68)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement2.position = CGPoint(x: size.width / 1.43, y: size.height / 1.83)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow9.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle9"
            shadowCircle2.position = CGPoint(x: size.width / 1.25, y: size.height / 1.75)
            addChild(shadowCircle2)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.81, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            let line2 = SKSpriteNode(imageNamed: GirlImageName.lineV.rawValue)
            line2.size = CGSize(width: size.width * 0.038, height: size.height * 0.33)
            line2.position = CGPoint(x: size.width / 2, y: size.height / 2.1)
            addChild(line2)
            
            shadowFruit3 = SKSpriteNode(imageNamed: GirlImageName.shadow3.rawValue)
            shadowFruit3.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit3.name = "shadowFruit3"
            shadowFruit3.zPosition = 1
            shadowFruit3.position = CGPoint(x: size.width / 1.65, y: size.height / 2.35)
            addChild(shadowFruit3)
            
            shadowElement3 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement3.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement3.position = CGPoint(x: size.width / 1.43, y: size.height / 2.65)
            shadowElement3.zPosition = 2
            addChild(shadowElement3)
            
            shadowCircle3 = SKSpriteNode(imageNamed: GirlImageName.shadow10.rawValue)
            shadowCircle3.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle3.zPosition = 3
            shadowCircle3.name  = "shadowCircle10"
            shadowCircle3.position = CGPoint(x: size.width / 1.25, y: size.height / 2.47)
            addChild(shadowCircle3)
            
            shadowFruit4 = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit4.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit4.name = "shadowFruit4"
            shadowFruit4.zPosition = 1
            shadowFruit4.position = CGPoint(x: size.width / 5, y: size.height / 2.35)
            addChild(shadowFruit4)
            
            shadowElement4 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement4.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement4.position = CGPoint(x: size.width / 3.4, y: size.height / 2.65)
            shadowElement4.zPosition = 2
            addChild(shadowElement4)
            
            shadowCircle4 = SKSpriteNode(imageNamed: GirlImageName.shadow5.rawValue)
            shadowCircle4.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle4.zPosition = 3
            shadowCircle4.name  = "shadowCircle5"
            shadowCircle4.position = CGPoint(x: size.width / 2.5, y: size.height / 2.47)
            addChild(shadowCircle4)

        case 9:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow11.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit.name = "shadowFruit11"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement.position = CGPoint(x: size.width / 3.4, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.ltShadow.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.41, height: size.width * 0.38)
            selectedShadowPart.position = CGPoint(x: size.width / 3.4, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow9.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle9"
            shadowCircle.position = CGPoint(x: size.width / 2.5, y: size.height / 1.75)
            addChild(shadowCircle)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit2.name = "shadowFruit7"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 1.65, y: size.height / 1.68)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement2.position = CGPoint(x: size.width / 1.43, y: size.height / 1.83)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow2.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle2"
            shadowCircle2.position = CGPoint(x: size.width / 1.25, y: size.height / 1.75)
            addChild(shadowCircle2)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.81, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            let line2 = SKSpriteNode(imageNamed: GirlImageName.lineV.rawValue)
            line2.size = CGSize(width: size.width * 0.038, height: size.height * 0.33)
            line2.position = CGPoint(x: size.width / 2, y: size.height / 2.1)
            addChild(line2)
            
            shadowFruit3 = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit3.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit3.name = "shadowFruit4"
            shadowFruit3.zPosition = 1
            shadowFruit3.position = CGPoint(x: size.width / 1.65, y: size.height / 2.35)
            addChild(shadowFruit3)
            
            shadowElement3 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement3.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement3.position = CGPoint(x: size.width / 1.43, y: size.height / 2.65)
            shadowElement3.zPosition = 2
            addChild(shadowElement3)
            
            shadowCircle3 = SKSpriteNode(imageNamed: GirlImageName.shadow5.rawValue)
            shadowCircle3.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle3.zPosition = 3
            shadowCircle3.name  = "shadowCircle5"
            shadowCircle3.position = CGPoint(x: size.width / 1.25, y: size.height / 2.47)
            addChild(shadowCircle3)
            
            shadowFruit4 = SKSpriteNode(imageNamed: GirlImageName.shadow3.rawValue)
            shadowFruit4.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit4.name = "shadowFruit3"
            shadowFruit4.zPosition = 1
            shadowFruit4.position = CGPoint(x: size.width / 5, y: size.height / 2.35)
            addChild(shadowFruit4)
            
            shadowElement4 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement4.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement4.position = CGPoint(x: size.width / 3.4, y: size.height / 2.65)
            shadowElement4.zPosition = 2
            addChild(shadowElement4)
            
            shadowCircle4 = SKSpriteNode(imageNamed: GirlImageName.shadow10.rawValue)
            shadowCircle4.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle4.zPosition = 3
            shadowCircle4.name  = "shadowCircle10"
            shadowCircle4.position = CGPoint(x: size.width / 2.5, y: size.height / 2.47)
            addChild(shadowCircle4)
        case 10:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit.name = "shadowFruit4"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement.position = CGPoint(x: size.width / 3.4, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.ltShadow.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.41, height: size.width * 0.38)
            selectedShadowPart.position = CGPoint(x: size.width / 3.4, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow5.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle5"
            shadowCircle.position = CGPoint(x: size.width / 2.5, y: size.height / 1.75)
            addChild(shadowCircle)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow3.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit2.name = "shadowFruit3"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 1.65, y: size.height / 1.68)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement2.position = CGPoint(x: size.width / 1.43, y: size.height / 1.83)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow10.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle10"
            shadowCircle2.position = CGPoint(x: size.width / 1.25, y: size.height / 1.75)
            addChild(shadowCircle2)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.81, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            let line2 = SKSpriteNode(imageNamed: GirlImageName.lineV.rawValue)
            line2.size = CGSize(width: size.width * 0.038, height: size.height * 0.33)
            line2.position = CGPoint(x: size.width / 2, y: size.height / 2.1)
            addChild(line2)
            
            shadowFruit3 = SKSpriteNode(imageNamed: GirlImageName.shadow11.rawValue)
            shadowFruit3.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit3.name = "shadowFruit11"
            shadowFruit3.zPosition = 1
            shadowFruit3.position = CGPoint(x: size.width / 1.65, y: size.height / 2.35)
            addChild(shadowFruit3)
            
            shadowElement3 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement3.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement3.position = CGPoint(x: size.width / 1.43, y: size.height / 2.65)
            shadowElement3.zPosition = 2
            addChild(shadowElement3)
            
            shadowCircle3 = SKSpriteNode(imageNamed: GirlImageName.shadow9.rawValue)
            shadowCircle3.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle3.zPosition = 3
            shadowCircle3.name  = "shadowCircle9"
            shadowCircle3.position = CGPoint(x: size.width / 1.25, y: size.height / 2.47)
            addChild(shadowCircle3)
            
            shadowFruit4 = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit4.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit4.name = "shadowFruit7"
            shadowFruit4.zPosition = 1
            shadowFruit4.position = CGPoint(x: size.width / 5, y: size.height / 2.35)
            addChild(shadowFruit4)
            
            shadowElement4 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement4.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement4.position = CGPoint(x: size.width / 3.4, y: size.height / 2.65)
            shadowElement4.zPosition = 2
            addChild(shadowElement4)
            
            shadowCircle4 = SKSpriteNode(imageNamed: GirlImageName.shadow2.rawValue)
            shadowCircle4.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle4.zPosition = 3
            shadowCircle4.name  = "shadowCircle2"
            shadowCircle4.position = CGPoint(x: size.width / 2.5, y: size.height / 2.47)
            addChild(shadowCircle4)
        case 11:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit.name = "shadowFruit7"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement.position = CGPoint(x: size.width / 3.4, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.ltShadow.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.41, height: size.width * 0.38)
            selectedShadowPart.position = CGPoint(x: size.width / 3.4, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow2.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle2"
            shadowCircle.position = CGPoint(x: size.width / 2.5, y: size.height / 1.75)
            addChild(shadowCircle)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow11.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit2.name = "shadowFruit11"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 1.65, y: size.height / 1.68)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement2.position = CGPoint(x: size.width / 1.43, y: size.height / 1.83)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow9.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle9"
            shadowCircle2.position = CGPoint(x: size.width / 1.25, y: size.height / 1.75)
            addChild(shadowCircle2)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.81, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            let line2 = SKSpriteNode(imageNamed: GirlImageName.lineV.rawValue)
            line2.size = CGSize(width: size.width * 0.038, height: size.height * 0.33)
            line2.position = CGPoint(x: size.width / 2, y: size.height / 2.1)
            addChild(line2)
            
            shadowFruit3 = SKSpriteNode(imageNamed: GirlImageName.shadow3.rawValue)
            shadowFruit3.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit3.name = "shadowFruit3"
            shadowFruit3.zPosition = 1
            shadowFruit3.position = CGPoint(x: size.width / 1.65, y: size.height / 2.35)
            addChild(shadowFruit3)
            
            shadowElement3 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement3.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement3.position = CGPoint(x: size.width / 1.43, y: size.height / 2.65)
            shadowElement3.zPosition = 2
            addChild(shadowElement3)
            
            shadowCircle3 = SKSpriteNode(imageNamed: GirlImageName.shadow10.rawValue)
            shadowCircle3.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle3.zPosition = 3
            shadowCircle3.name  = "shadowCircle10"
            shadowCircle3.position = CGPoint(x: size.width / 1.25, y: size.height / 2.47)
            addChild(shadowCircle3)
            
            shadowFruit4 = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit4.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit4.name = "shadowFruit4"
            shadowFruit4.zPosition = 1
            shadowFruit4.position = CGPoint(x: size.width / 5, y: size.height / 2.35)
            addChild(shadowFruit4)
            
            shadowElement4 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement4.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement4.position = CGPoint(x: size.width / 3.4, y: size.height / 2.65)
            shadowElement4.zPosition = 2
            addChild(shadowElement4)
            
            shadowCircle4 = SKSpriteNode(imageNamed: GirlImageName.shadow5.rawValue)
            shadowCircle4.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle4.zPosition = 3
            shadowCircle4.name  = "shadowCircle5"
            shadowCircle4.position = CGPoint(x: size.width / 2.5, y: size.height / 2.47)
            addChild(shadowCircle4)
        case 12:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit.name = "shadowFruit4"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 5, y: size.height / 1.68)
            addChild(shadowFruit)
            
            shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement.position = CGPoint(x: size.width / 3.4, y: size.height / 1.83)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.ltShadow.rawValue)
            selectedShadowPart.size = CGSize(width: size.width * 0.41, height: size.width * 0.38)
            selectedShadowPart.position = CGPoint(x: size.width / 3.4, y: size.height / 1.78)
            addChild(selectedShadowPart)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow5.rawValue)
            shadowCircle.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle5"
            shadowCircle.position = CGPoint(x: size.width / 2.5, y: size.height / 1.75)
            addChild(shadowCircle)
            
            shadowFruit2 = SKSpriteNode(imageNamed: GirlImageName.shadow3.rawValue)
            shadowFruit2.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit2.name = "shadowFruit3"
            shadowFruit2.zPosition = 1
            shadowFruit2.position = CGPoint(x: size.width / 1.65, y: size.height / 1.68)
            addChild(shadowFruit2)
            
            shadowElement2 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement2.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement2.position = CGPoint(x: size.width / 1.43, y: size.height / 1.83)
            shadowElement2.zPosition = 2
            addChild(shadowElement2)
            
            shadowCircle2 = SKSpriteNode(imageNamed: GirlImageName.shadow10.rawValue)
            shadowCircle2.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle2.zPosition = 3
            shadowCircle2.name  = "shadowCircle10"
            shadowCircle2.position = CGPoint(x: size.width / 1.25, y: size.height / 1.75)
            addChild(shadowCircle2)
            
            let line = SKSpriteNode(imageNamed: GirlImageName.lineH.rawValue)
            line.size = CGSize(width: size.width * 0.81, height: size.width * 0.038)
            line.position = CGPoint(x: size.width / 2, y: size.height / 2.15)
            addChild(line)
            
            let line2 = SKSpriteNode(imageNamed: GirlImageName.lineV.rawValue)
            line2.size = CGSize(width: size.width * 0.038, height: size.height * 0.33)
            line2.position = CGPoint(x: size.width / 2, y: size.height / 2.1)
            addChild(line2)
            
            shadowFruit3 = SKSpriteNode(imageNamed: GirlImageName.shadow11.rawValue)
            shadowFruit3.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit3.name = "shadowFruit11"
            shadowFruit3.zPosition = 1
            shadowFruit3.position = CGPoint(x: size.width / 1.65, y: size.height / 2.35)
            addChild(shadowFruit3)
            
            shadowElement3 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement3.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement3.position = CGPoint(x: size.width / 1.43, y: size.height / 2.65)
            shadowElement3.zPosition = 2
            addChild(shadowElement3)
            
            shadowCircle3 = SKSpriteNode(imageNamed: GirlImageName.shadow9.rawValue)
            shadowCircle3.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle3.zPosition = 3
            shadowCircle3.name  = "shadowCircle9"
            shadowCircle3.position = CGPoint(x: size.width / 1.25, y: size.height / 2.47)
            addChild(shadowCircle3)
            
            shadowFruit4 = SKSpriteNode(imageNamed: GirlImageName.shadow7.rawValue)
            shadowFruit4.size = CGSize(width: size.width * 0.108, height: size.width * 0.148)
            shadowFruit4.name = "shadowFruit7"
            shadowFruit4.zPosition = 1
            shadowFruit4.position = CGPoint(x: size.width / 5, y: size.height / 2.35)
            addChild(shadowFruit4)
            
            shadowElement4 = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement4.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
            shadowElement4.position = CGPoint(x: size.width / 3.4, y: size.height / 2.65)
            shadowElement4.zPosition = 2
            addChild(shadowElement4)
            
            shadowCircle4 = SKSpriteNode(imageNamed: GirlImageName.shadow2.rawValue)
            shadowCircle4.size = CGSize(width: size.width * 0.12, height: size.width * 0.113)
            shadowCircle4.zPosition = 3
            shadowCircle4.name  = "shadowCircle2"
            shadowCircle4.position = CGPoint(x: size.width / 2.5, y: size.height / 2.47)
            addChild(shadowCircle4)
        default:
            shadowFruit = SKSpriteNode(imageNamed: GirlImageName.shadow4.rawValue)
            shadowFruit.size = CGSize(width: 81, height: 100)
            shadowFruit.name = "shadowFruit4"
            shadowFruit.zPosition = 1
            shadowFruit.position = CGPoint(x: size.width / 3.5, y: size.height / 1.85)
            addChild(shadowFruit)
            
            let shadowElement = SKSpriteNode(imageNamed: GirlImageName.shadow6.rawValue)
            shadowElement.size = CGSize(width: 221, height: 154)
            shadowElement.position = CGPoint(x: size.width / 2, y: size.height / 2.3)
            shadowElement.zPosition = 2
            addChild(shadowElement)
            
            shadowCircle = SKSpriteNode(imageNamed: GirlImageName.shadow10.rawValue)
            shadowCircle.size = CGSize(width: 89, height: 93)
            shadowCircle.zPosition = 3
            shadowCircle.name  = "shadowCircle10"
            shadowCircle.position = CGPoint(x: size.width / 1.5, y: size.height / 2.1)
            addChild(shadowCircle)
        }
    }
    
    func setupView() {
        createMainView()
        createTappedView()
        createMutatingView()
        createMistake()
        createElement()
        createShadow()
    }
    
    func createProgress() {
        let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 595, width: 0, height: 16), cornerRadius: 8)
        progressBarNode = SKShapeNode(path: path.cgPath)
        progressBarNode.lineWidth = 0
        progressBarNode.fillColor = SKColor(Color(red: 255/255, green: 0/255, blue: 191/255))
   
        addChild(progressBarNode)
        
        var duration: TimeInterval = 120
        
        if level < 4 {
            duration = 120
        } else if level > 4, level < 8 {
            duration = 120
        } else if level >= 8 {
            duration = 100
        }
        
        let action = SKAction.customAction(withDuration: duration) { node, elapsedTime in
            if self.game!.isLose || self.game!.isWin || self.game!.isPause || self.game!.isRules {
                return
            }
            
            let progress = elapsedTime / duration
            let width = CGFloat(progress) * 360
            
            let newPath = UIBezierPath(roundedRect: CGRect(x: 20, y: 598, width: width, height: 10), cornerRadius: 8)
            self.progressBarNode.path = newPath.cgPath
            
            if elapsedTime >= duration {
                self.game!.isLose = true
            }
        }
        
        progressBarNode.run(action)
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        size = UIScreen.main.bounds.size
        setupView()
        createProgress()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        movableNode?.position = location
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        tapOnPause(touchLocation: location)
        tapOnRules(touchLocation: location)
        tapOnTimeBonus(touchLocation: location)
        tapOnMistakeBonus(touchLocation: location)
        
        let nodes = atPoint(location) as? SKSpriteNode
        
        guard let node = nodes else { return }
        
        if level >= 0, level < 4 {
            if let nodeName = node.name, nodeName.hasPrefix("fruit") {
                movableNode = SKSpriteNode(texture: node.texture)
                movableNode?.size = CGSize(width: size.width * 0.21, height: size.width * 0.27)
                movableNode?.position = node.position
                movableNode?.zPosition = 3
                movableNode?.name = nodeName
                addChild(movableNode!)
            } else if let nodeName = node.name, nodeName.hasPrefix("element") {
                movableNode = SKSpriteNode(texture: node.texture)
                movableNode?.size = CGSize(width: size.width * 0.565, height: size.width * 0.39)
                movableNode?.position = node.position
                movableNode?.zPosition = 3
                movableNode?.name = nodeName
                addChild(movableNode!)
            } else if let nodeName = node.name, nodeName.hasPrefix("circle") {
                movableNode = SKSpriteNode(texture: node.texture)
                movableNode?.size = CGSize(width: size.width * 0.227, height: size.width * 0.236)
                movableNode?.position = node.position
                movableNode?.zPosition = 3
                movableNode?.name = nodeName
                addChild(movableNode!)
            }
        } else if level >= 4, level < 13 {
            if let nodeName = node.name, nodeName.hasPrefix("fruit") {
                movableNode = SKSpriteNode(texture: node.texture)
                movableNode?.size = CGSize(width: size.width * 0.12, height: size.width * 0.125)
                movableNode?.position = node.position
                movableNode?.zPosition = 3
                movableNode?.name = nodeName
                addChild(movableNode!)
            } else if let nodeName = node.name, nodeName.hasPrefix("element") {
                movableNode = SKSpriteNode(texture: node.texture)
                movableNode?.size = CGSize(width: size.width * 0.31, height: size.width * 0.22)
                movableNode?.position = node.position
                movableNode?.zPosition = 3
                movableNode?.name = nodeName
                addChild(movableNode!)
            } else if let nodeName = node.name, nodeName.hasPrefix("circle") {
                movableNode = SKSpriteNode(texture: node.texture)
                movableNode?.size = CGSize(width: size.width * 0.12, height: size.width * 0.12)
                movableNode?.position = node.position
                movableNode?.zPosition = 3
                movableNode?.name = nodeName
                addChild(movableNode!)
            }
        }
    }
    
    func handleCorrectPlacement(node: SKSpriteNode, type: String) {
        removeAllElements(ofType: type)
    }
    
    func handleWrongPlacement() {
        movableNode?.removeFromParent()
        game!.mistakes += 1
        updateMistakeNodes()
    }
    
    func removeAllElements(ofType type: String) {
        for child in children {
            if child.name?.hasPrefix(type) == true {
                child.removeFromParent()
            }
        }
    }
    
    func checkPosition(node: SKSpriteNode, shadow: SKSpriteNode) -> Bool {
        let tolerance: CGFloat = 20
        return abs(node.position.x - shadow.position.x) < tolerance &&
        abs(node.position.y - shadow.position.y) < tolerance
    }
    
    func removeAllElements() {
        removeAllElements(ofType: "element")
        removeAllElements(ofType: "fruit")
        removeAllElements(ofType: "circle")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let movableNode = movableNode else { return }
        
        if level >= 4 {
            var activeFruitShadow: SKSpriteNode!
            var activeCircleShadow: SKSpriteNode!
            var activeElementShadow: SKSpriteNode!
            
            switch currentSet {
            case 1:
                activeFruitShadow = shadowFruit
                activeCircleShadow = shadowCircle
                activeElementShadow = shadowElement
            case 2:
                activeFruitShadow = shadowFruit2
                activeCircleShadow = shadowCircle2
                activeElementShadow = shadowElement2
            case 3:
                activeFruitShadow = shadowFruit3
                activeCircleShadow = shadowCircle3
                activeElementShadow = shadowElement3
            case 4:
                activeFruitShadow = shadowFruit4
                activeCircleShadow = shadowCircle4
                activeElementShadow = shadowElement4
            default:
                movableNode.removeFromParent()
                return
            }
            
            if movableNode.name?.hasPrefix("element") == true {
                if checkPosition(node: movableNode, shadow: activeElementShadow!) {
                    movableNode.name = nil
                    movableNode.zPosition = 2
                    handleCorrectPlacement(node: movableNode, type: "element")
                    createFruit()
                } else {
                    handleWrongPlacement()
                }
            } else if movableNode.name?.hasPrefix("fruit") == true {
                if checkPosition(node: movableNode, shadow: activeFruitShadow!) &&
                    nodeShadowMap[movableNode.name!] == activeFruitShadow!.name {
                    movableNode.name = nil
                    movableNode.zPosition = 1
                    handleCorrectPlacement(node: movableNode, type: "fruit")
                    createCircle()
                } else {
                    handleWrongPlacement()
                }
            } else if movableNode.name?.hasPrefix("circle") == true {
                if checkPosition(node: movableNode, shadow: activeCircleShadow!) &&
                    nodeShadowMap[movableNode.name!] == activeCircleShadow!.name {
                    movableNode.name = nil
                    movableNode.zPosition = 3
                    handleCorrectPlacement(node: movableNode, type: "circle")
                    
                    if level >= 8 {
                        if currentSet < 4 {
                            currentSet += 1
                            removeAllElements()
                            
                            switch currentSet {
                            case 2:
                                selectedShadowPart.removeFromParent()
                                selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.rtShadow.rawValue)
                                selectedShadowPart.size = CGSize(width: size.width * 0.41, height: size.height * 0.18)
                                selectedShadowPart.position = CGPoint(x: size.width / 1.41, y: size.height / 1.78)
                                addChild(selectedShadowPart)
                            case 3:
                                selectedShadowPart.removeFromParent()
                                selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.rbShadow.rawValue)
                                selectedShadowPart.size = CGSize(width: 162, height: 130)
                                selectedShadowPart.position = CGPoint(x: size.width / 1.41, y: size.height / 2.56)
                                addChild(selectedShadowPart)
                            case 4:
                                selectedShadowPart.removeFromParent()
                                selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.lbShadow.rawValue)
                                selectedShadowPart.size = CGSize(width: 160, height: 130)
                                selectedShadowPart.position = CGPoint(x: size.width / 3.37, y: size.height / 2.54)
                                addChild(selectedShadowPart)
                            default:
                                break
                            }
                            
                            createElement()
                        } else {
                            game!.isWin = true
                        }
                    } else if level >= 4 && level < 8 {
                        if currentSet == 2 {
                            game!.isWin = true
                        } else {
                            currentSet += 1
                            removeAllElements()
                            
                            if currentSet == 2 {
                                selectedShadowPart.removeFromParent()
                                selectedShadowPart = SKSpriteNode(imageNamed: GirlImageName.selectedShadowPart2.rawValue)
                                selectedShadowPart.size = CGSize(width: 325, height: 130)
                                selectedShadowPart.position = CGPoint(x: size.width / 2, y: size.height / 2.57)
                                addChild(selectedShadowPart)
                            }
                            
                            createElement()
                        }
                    }
                } else {
                    handleWrongPlacement()
                }
            }
        } else {
            if movableNode.name?.hasPrefix("element") == true {
                let shadowElementPosition = CGPoint(x: size.width / 2, y: size.height / 2.3)
                let tolerance: CGFloat = 20
                if abs(movableNode.position.x - shadowElementPosition.x) < tolerance &&
                   abs(movableNode.position.y - shadowElementPosition.y) < tolerance {
                    movableNode.position = shadowElementPosition
                    movableNode.name = nil
                    movableNode.zPosition = 2
                    for child in children {
                        if child.name?.hasPrefix("element") == true && child !== movableNode {
                            child.removeFromParent()
                        }
                    }
                    createFruit()
                } else {
                    movableNode.removeFromParent()
                }
            } else if movableNode.name?.hasPrefix("fruit") == true {
                let nodeName = movableNode.name ?? ""
                let shadowName = shadowFruit.name ?? ""
                if let nodeShadowName = nodeShadowMap[nodeName] {
                    if nodeShadowName == shadowName {
                        let tolerance: CGFloat = 20
                        if abs(movableNode.position.x - shadowFruit.position.x) < tolerance &&
                           abs(movableNode.position.y - shadowFruit.position.y) < tolerance {
                            movableNode.position = shadowFruit.position
                            movableNode.zPosition = 1
                            movableNode.name = nil
                            for child in children {
                                if child.name?.hasPrefix("fruit") == true && child !== movableNode {
                                    child.removeFromParent()
                                }
                            }
                            createCircle()
                        } else {
                            movableNode.removeFromParent()
                            game!.mistakes += 1
                            updateMistakeNodes()
                        }
                    } else {
                        movableNode.removeFromParent()
                        game!.mistakes += 1
                        updateMistakeNodes()
                    }
                } else {
                    movableNode.removeFromParent()
                    game!.mistakes += 1
                    updateMistakeNodes()
                }
            } else if movableNode.name?.hasPrefix("circle") == true {
                let nodeName = movableNode.name ?? ""
                let shadowName = shadowCircle.name ?? ""
                if let nodeShadowName = nodeShadowMap[nodeName] {
                    if nodeShadowName == shadowName {
                        let tolerance: CGFloat = 20
                        if abs(movableNode.position.x - shadowCircle.position.x) < tolerance &&
                           abs(movableNode.position.y - shadowCircle.position.y) < tolerance {
                            movableNode.position = shadowCircle.position
                            movableNode.zPosition = 3
                            movableNode.name = nil
                            for child in children {
                                if child.name?.hasPrefix("circle") == true && child !== movableNode {
                                    child.removeFromParent()
                                }
                            }
                            game!.isWin = true
                        } else {
                            movableNode.removeFromParent()
                            game!.mistakes += 1
                            updateMistakeNodes()
                        }
                    } else {
                        movableNode.removeFromParent()
                        game!.mistakes += 1
                        updateMistakeNodes()
                    }
                } else {
                    movableNode.removeFromParent()
                    game!.mistakes += 1
                    updateMistakeNodes()
                }
            }
        }
        
        self.movableNode = nil
    }
}

struct GirlGameView: View {
    @StateObject var girlGameModel =  GirlGameViewModel()
    @StateObject var gameModel = GirlGameData()
    var level: Int
    var body: some View {
        ZStack {
            SpriteView(scene: girlGameModel.createGirlGameScene(gameData: gameModel, level: level))
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            if gameModel.isPause {
                GirlPauseView(game: gameModel, scene: gameModel.scene)
            }
            
            if gameModel.isRules {
                GirlRulesView(game: gameModel, scene: gameModel.scene)
            }
            
            if gameModel.isWin {
                GirlVictoryView(level: level)
                    .onAppear() {
                        if level == UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) {
                            UserDefaultsManager().completeLevel()
                        }
                    }
            }
            
            if gameModel.isLose {
                GirlLoseView(level: level)
                    .onAppear() {
                        UserDefaultsManager().loseLevel()
                    }
            }
        }
    }
}

#Preview {
    GirlGameView(level: 9)
}
