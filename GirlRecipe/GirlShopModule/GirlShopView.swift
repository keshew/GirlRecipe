import SwiftUI

struct GirlShopView: View {
    @StateObject var girlShopModel =  GirlShopViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.mainBackground)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(.girl2)
                    .resizable()
                    .frame(width: geometry.size.width / 1.1, height: geometry.size.height / 1.7)
                    .position(x: geometry.size.width / 1.8, y: geometry.size.height / 1.29)
                
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
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.back)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.1825, height: geometry.size.height * 0.105)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: geometry.size.height * -0.0125)
                        
                        Text("SHOP")
                            .Unlock(size: 60)
                        
                        Spacer(minLength: geometry.size.height * -0.0125)
                        
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
                        
                        if girlShopModel.currentIndex == 1 {
                            CustomBonusMistake(geometry: geometry) {
                                girlShopModel.userDef.buyBonus(key: Keys.lifes.rawValue)
                                girlShopModel.again = 1
                            }
                        } else if girlShopModel.currentIndex == 2 {
                            CustomTime(geometry: geometry) {
                                girlShopModel.userDef.buyBonus(key: Keys.mistakeCount.rawValue)
                                girlShopModel.again = 1
                            }
                        } else {
                            CustomLives(geometry: geometry) {
                                girlShopModel.userDef.buyBonus(key: Keys.timeCount.rawValue)
                                girlShopModel.again = 1
                            }
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.2875)
                        
                        Text("SWIPE LEFT\\RIGHT to NEXT\\PREV PAGE")
                            .Unlock(size: 25)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onChanged({ value in
                        girlShopModel.dragOffset = value.translation.width
                        girlShopModel.isDragging = true
                    })
                    .onEnded({ value in
                        if abs(value.translation.width) > 50 {
                            if value.translation.width > 0 {
                                if girlShopModel.currentIndex > 0 {
                                    girlShopModel.currentIndex -= 1
                                }
                            } else {
                                if girlShopModel.currentIndex <= 1 {
                                    girlShopModel.currentIndex += 1
                                }
                            }
                        }
                        girlShopModel.dragOffset = 0
                        girlShopModel.isDragging = false
                    })
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GirlShopView()
}
