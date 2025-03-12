import SwiftUI

struct GirlLoseView: View {
    @StateObject var girlLoseModel =  GirlLoseViewModel()
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
                        Text("GAME OVER")
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
                                
                                Text("LIVES\n:\(UserDefaultsManager.defaults.integer(forKey: Keys.money.rawValue))")
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
                                Text("It's sad that you didn't collect the dish and didn't get the coins.")
                                    .Unlock(size: 20)
                                    .frame(width: geometry.size.width * 0.755)
                                    .multilineTextAlignment(.center)
                                
                                HStack {
                                    Text("-30")
                                        .Unlock(size: 50)
                                    
                                    Image(.coin)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.1325, height: geometry.size.width * 0.1325)
                                }
                            }
                            
                            VStack {
                                NavigationLink(destination: GirlGameView(level: level)) {
                                    ZStack {
                                        Image(.blueButton)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.545, height: geometry.size.height * 0.1075)
                                        
                                        Text("RETRY")
                                            .Unlock(size: 25)
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
                            .offset(x: geometry.size.width * -0.22, y: geometry.size.height * 0.299)
                        }
                    }
                }
            }
            .onAppear() {
                audioManager.playLoseMusic()
                audioManager.stopBackgroundMusic()
            }
            
            .onDisappear {
                audioManager.playBackgroundMusic()
                audioManager.stopLoseMusic()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GirlLoseView(level: 1)
}

