import SwiftUI

struct GirlLevelView: View {
    @StateObject var girlLevelModel =  GirlLevelViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.levelBack)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(.topShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 6)
                
                Image(.bottomShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.2)
                
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
                    
                    Text("LEVELS")
                        .Unlock(size: 60)
                    
                    Spacer()
                }
                .padding(.top)
                
                LevelPin(text: "1")
                    .position(x: geometry.size.width / 2.2, y: geometry.size.height / 1.14)
                
                LevelPin(text: "2")
                    .position(x: geometry.size.width / 2.0, y: geometry.size.height / 1.22)
                
                LevelPin(text: "3")
                    .position(x: geometry.size.width / 1.7, y: geometry.size.height / 1.3)
                
                LevelPin(text: "4")
                    .position(x: geometry.size.width / 1.7, y: geometry.size.height / 1.41)
                
                LevelPin(text: "5")
                    .position(x: geometry.size.width / 1.93, y: geometry.size.height / 1.51)
                
                LevelPin(text: "6")
                    .position(x: geometry.size.width / 2.15, y: geometry.size.height / 1.68)
                
                LevelPin(text: "7")
                    .position(x: geometry.size.width / 1.85, y: geometry.size.height / 1.82)
                
                LevelPin(text: "8")
                    .position(x: geometry.size.width / 1.53, y: geometry.size.height / 1.92)
                
                LevelPin(text: "9")
                    .position(x: geometry.size.width / 1.3, y: geometry.size.height / 1.99)
                
                LevelPin(text: "10")
                    .position(x: geometry.size.width / 1.15, y: geometry.size.height / 2.2)
                
                LevelPin(text: "11")
                    .position(x: geometry.size.width / 1.3, y: geometry.size.height / 2.4)
                
                LevelPin(text: "12")
                    .position(x: geometry.size.width / 1.2, y: geometry.size.height / 2.8)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GirlLevelView()
}


struct LevelPin: View {
    var text: String
    var body: some View {
        if UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) >= Int(text) ?? 0 {
            NavigationLink(destination: GirlGameView(level: Int(text) ?? 1)) {
                ZStack {
                    Image(.openLevel)
                        .resizable()
                        .frame(width: 48, height: 46)
                    
                    Text(text)
                        .Unlock(size: 20)
                        .offset(x: -1, y: -1)
                }
            }
        } else {
            ZStack {
                Image(.lockedLevel)
                    .resizable()
                    .frame(width: 48, height: 46)
                
                Text(text)
                    .Unlock(size: 20, colorOutline: .black)
                    .offset(x: -1, y: -1)
            }
        }
    }
}
