import SwiftUI

struct GirlReceptView: View {
    @StateObject var girlReceptModel =  GirlReceptViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.mainBackground)
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
                        
                        Text("RECIPES")
                            .Unlock(size: 60)
                        
                        Image(girlReceptModel.contact.arrayOfImage[girlReceptModel.currentIndex])
                            .resizable()
                            .frame(width: geometry.size.width * 0.745, height: geometry.size.height * 0.23875)
                        
                        ZStack {
                            Image(.settingsBack)
                                .resizable()
                                .frame(width: geometry.size.width * 0.76, height: geometry.size.height * 0.43125)
                            
                            Text(girlReceptModel.contact.arrayOfText[girlReceptModel.currentIndex])
                                .Unlock(size: 20, outlineWidth: 0.5)
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.425)
                                .minimumScaleFactor(0.8)
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.025)
                        
                        Text("SWIPE LEFT\\RIGHT to NEXT\\PREV PAGE")
                            .Unlock(size: 25)
                    }
                }
                
                if UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) - 1 < girlReceptModel.currentIndex + 1 {
                    ZStack {
                        Color(.black)
                            .ignoresSafeArea()
                            .opacity(0.8)
                        
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
                                
                                Text("RECIPES")
                                    .Unlock(size: 60)
                                
                                Spacer(minLength: geometry.size.height * 0.0375)
                                
                                Image(.lock)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.28, height: geometry.size.height * 0.175)
                                
                                Spacer(minLength: geometry.size.height * 0.04375)
                                
                                ZStack {
                                    Image(.settingsBack)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.76, height: geometry.size.height * 0.43125)
                                    
                                    Text("While it's closed, you need to complete the previous level to unlock this recipe!")
                                        .Unlock(size: 30, outlineWidth: 0.5)
                                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.425)
                                        .minimumScaleFactor(0.8)
                                        .multilineTextAlignment(.center)
                                }
                                
                                Spacer(minLength: geometry.size.height * 0.025)
                                
                                Text("SWIPE LEFT\\RIGHT to NEXT\\PREV PAGE")
                                    .Unlock(size: 25)
                            }
                        }
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onChanged({ value in
                        girlReceptModel.dragOffset = value.translation.width
                        girlReceptModel.isDragging = true
                    })
                    .onEnded({ value in
                        if abs(value.translation.width) > 50 {
                            if value.translation.width > 0 {
                                if girlReceptModel.currentIndex > 0 {
                                    girlReceptModel.currentIndex -= 1
                                }
                            } else {
                                if girlReceptModel.currentIndex <= 10 {
                                    girlReceptModel.currentIndex += 1
                                }
                            }
                        }
                        girlReceptModel.dragOffset = 0
                        girlReceptModel.isDragging = false
                    })
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GirlReceptView()
}

