import SwiftUI

struct GirlMenuView: View {
    @StateObject var girlMenuModel =  GirlMenuViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.mainBackground)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(.girl1)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.52)
                
                Image(.topShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 6)
                
                Image(.bottomShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.2)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            NavigationLink(destination: GirlSettingsView()) {
                                Image(.settings)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.1825, height: geometry.size.height * 0.105)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        Text("SWEET JELLY\nLAYERS")
                            .Unlock(size: 50)
                            .multilineTextAlignment(.center)
                        
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
                        
                        Spacer(minLength: geometry.size.height * 0.175)
                        
                        VStack {
                            NavigationLink(destination: GirlLevelView()) {
                                Image(.play)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.6775, height: geometry.size.height * 0.175)
                            }
                            
                            HStack {
                                NavigationLink(destination: GirlReceptView()) {
                                    Image(.recipes)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.475, height: geometry.size.height * 0.09875)
                                }
                                
                                NavigationLink(destination: GirlShopView()) {
                                    Image(.shop)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.475, height: geometry.size.height * 0.09875)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GirlMenuView()
}

