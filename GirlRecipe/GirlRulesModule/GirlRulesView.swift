import SwiftUI
import SpriteKit

struct GirlRulesView: View {
    @StateObject var girlRulesModel =  GirlRulesViewModel()
    var game: GirlGameData
    var scene: SKScene
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.black)
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                Image(.girl2)
                    .resizable()
                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.475)
                    .position(x: geometry.size.width / 1.6, y: geometry.size.height / 1.25)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Text("RULES")
                            .Unlock(size: 60)
                        
                        Spacer(minLength: 20)
                        
                        HStack(spacing: geometry.size.width * 0.075) {
                            ZStack {
                                Image(.backForBudget)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.4225, height: geometry.size.height * 0.08375)
                                
                                Image(.coin)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.22, height: geometry.size.width * 0.22)
                                    .offset(x: -geometry.size.width * 0.15)
                                
                                Text("COINS\n:\(UserDefaultsManager.defaults.integer(forKey: Keys.money.rawValue))")
                                    .Unlock(size: 18)
                                    .offset(x: geometry.size.width * 0.0375)
                            }
                            
                            ZStack {
                                Image(.backForBudget)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.4225, height: geometry.size.height * 0.08375)
                                
                                Image(.heart)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.2475, height: geometry.size.width * 0.2475)
                                    .offset(x: -geometry.size.width * 0.15)
                                
                                Text("LIVES\n:\(UserDefaultsManager.defaults.integer(forKey: Keys.lifes.rawValue))")
                                    .Unlock(size: 18)
                                    .multilineTextAlignment(.center)
                                    .offset(x: geometry.size.width * 0.0375)
                            }
                        }
                        
                        ZStack {
                            Image(.winBack)
                                .resizable()
                                .frame(width: geometry.size.width * 0.905, height: geometry.size.height * 0.35125)
                            
                            VStack(spacing: 0) {
                                Text("You need to determine from the silhouette what the cake is made of, but in a limited time and for limited mistakes.")
                                    .Unlock(size: 30, outlineWidth: 0.7)
                                    .minimumScaleFactor(0.7)
                                    .frame(width: geometry.size.width * 0.8)
                                    .multilineTextAlignment(.center)
                            }
                            
                            VStack {
                                Button(action: {
                                    game.isRules = false
                                    scene.isPaused = false
                                }) {
                                    ZStack {
                                        Image(.blueButton)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.545, height: geometry.size.height * 0.1075)

                                        Text("CONTINUE")
                                            .Unlock(size: 25)
                                    }
                                }
                                
                                Color.clear
                                    .frame(height: geometry.size.height * 0.1075)
                            }
                            .offset(x: geometry.size.width * -0.22, y: geometry.size.height * 0.299)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let game = GirlGameData()
    GirlRulesView(game: game, scene: game.scene)
}

