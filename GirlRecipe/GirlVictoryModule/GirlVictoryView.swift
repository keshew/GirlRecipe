import SwiftUI

struct GirlVictoryView: View {
    @StateObject var girlVictoryModel =  GirlVictoryViewModel()
    @ObservedObject var audioManager = AudioManager.shared
    var level: Int
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
                        Text("VICTORY")
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
                                    .offset(x: -geometry.size.width * 0.13)
                                
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
                                Text("Congratulations, you have collected the dish and received the coins.")
                                    .Unlock(size: 20)
                                    .frame(width: geometry.size.width * 0.805)
                                    .multilineTextAlignment(.center)
                                
                                HStack {
                                    Text("+30")
                                        .Unlock(size: 50)
                                    
                                    Image(.coin)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.1325, height: geometry.size.width * 0.1325)
                                }
                                
                                if level == UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) {
                                    Text("And the recipe")
                                        .Unlock(size: 20)
                                    
                                    Image(girlVictoryModel.imageRecipe(level: level))
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.3175, height: geometry.size.height * 0.1025)
                                        .cornerRadius(geometry.size.width * 0.05)
                                }
                            }
                            
                            VStack {
                                if level != 12 {
                                    NavigationLink(destination: GirlGameView(level: level + 1)) {
                                        ZStack {
                                            Image(.blueButton)
                                                .resizable()
                                                .frame(width: geometry.size.width * 0.545, height: geometry.size.height * 0.1075)
                                            
                                            Text("NEXT")
                                                .Unlock(size: 25)
                                        }
                                    }
                                }
                                
                                NavigationLink(destination: GirlMenuView()) {
                                    ZStack {
                                        Image(.blueButton)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.545, height: geometry.size.height * 0.1075)
                                        
                                        Text("MENU")
                                            .Unlock(size: 25)
                                    }
                                }
                            }
                            .offset(x: -geometry.size.width * 0.22, y: geometry.size.height * 0.299)
                        }
                    }
                }
            }
            .onAppear() {
                audioManager.playWinMusic()
                audioManager.stopBackgroundMusic()
            }
            
            .onDisappear {
                audioManager.playBackgroundMusic()
                audioManager.stopWinMusic()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    

}

#Preview {
    GirlVictoryView(level: 1)
}

