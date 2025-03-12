import SwiftUI

struct CustomBonusMistake: View {
    var geometry: GeometryProxy
    var action: (() -> ())
    var body: some View {
        ZStack {
            Image(.settingsBack)
                .resizable()
                .frame(width: 361, height: 256)
            
            VStack {
                Text("BONUS MISTAKES")
                    .Unlock(size: 25)
                
                VStack(spacing: 0) {
                    HStack(spacing: 20) {
                        Image(.bonusMistake)
                            .resizable()
                            .frame(width: 87, height: 67)
                        
                        Text("X 3")
                            .Unlock(size: 40)
                    }
                    .offset(x: -15)
                    
                    Text("Gives you bonus\nattempts to solve\nthe puzzle.")
                        .Unlock(size: 25)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 0) {
                        Text("COST:60")
                            .Unlock(size: 20)
                        
                        Image(.coin)
                            .resizable()
                            .frame(width: 34, height: 34)
                    }
                }
            }
            
            Button(action: {
                action()
            }) {
                ZStack {
                    Image(.blueButton)
                        .resizable()
                        .frame(width: 217, height: 86)
                    
                    Text("BUY")
                        .Unlock(size: 25)
                }
            }
            .offset(x: -85, y: 155)
        }
    }
}

struct CustomTime: View {
    var geometry: GeometryProxy
    var action: (() -> ())
    var body: some View {
        ZStack {
            Image(.settingsBack)
                .resizable()
                .frame(width: 361, height: 256)
            
            VStack {
                Text("BONUS TIME")
                    .Unlock(size: 25)
                
                VStack(spacing: 0) {
                    HStack(spacing: 20) {
                        Image(.bonusTime)
                            .resizable()
                            .frame(width: 67, height: 73)
                        
                        Text("X 3")
                            .Unlock(size: 40)
                    }
                    .offset(x: -15)
                    
                    Text("Gives you a bonus\ntime to solve the\npuzzle.")
                        .Unlock(size: 25)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 0) {
                        Text("COST:60")
                            .Unlock(size: 20)
                        
                        Image(.coin)
                            .resizable()
                            .frame(width: 34, height: 34)
                    }
                }
            }
            
            Button(action: {
                action()
            }) {
                ZStack {
                    Image(.blueButton)
                        .resizable()
                        .frame(width: 217, height: 86)
                    
                    Text("BUY")
                        .Unlock(size: 25)
                }
            }
            .offset(x: -85, y: 155)
        }
    }
}

struct CustomLives: View {
    var geometry: GeometryProxy
    var action: (() -> ())
    var body: some View {
        ZStack {
            Image(.settingsBack)
                .resizable()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.32)
            
            VStack {
                Text("LIVES")
                    .Unlock(size: 40)
                
                VStack(spacing: 0) {
                    HStack(spacing: geometry.size.width * 0.05) {
                        Image(.heart)
                            .resizable()
                            .frame(width: geometry.size.width * 0.325, height: geometry.size.width * 0.325)
                        
                        Text("X 3")
                            .Unlock(size: 40)
                    }
                    .offset(x: -geometry.size.width * 0.0375)
                    HStack(spacing: 0) {
                        Text("COST:60")
                            .Unlock(size: 20)
                        
                        Image(.coin)
                            .resizable()
                            .frame(width: geometry.size.width * 0.085, height: geometry.size.width * 0.085)
                    }
                }
            }
            
            Button(action: {
                action()
            }) {
                ZStack {
                    Image(.blueButton)
                        .resizable()
                        .frame(width: geometry.size.width * 0.545, height: geometry.size.height * 0.1075)
                    
                    Text("BUY")
                        .Unlock(size: 25)
                }
            }
            .offset(x: -geometry.size.width * 0.2125, y: geometry.size.height * 0.19375)
        }
    }
}
