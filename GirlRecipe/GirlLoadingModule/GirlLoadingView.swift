import SwiftUI

struct GirlLoadingView: View {
    @StateObject var girlLoadingModel =  GirlLoadingViewModel()
    @ObservedObject var audioManager = AudioManager.shared
    var body: some View {
        NavigationView {
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
                    
                    VStack {
                        Spacer()
                        
                        VStack {
                            Text(girlLoadingModel.currentText)
                                .Unlock(size: 40)
                            
                            ZStack {
                                Rectangle()
                                    .fill(.black)
                                    .frame(width: 281, height: 16)
                                    .opacity(0.6)
                                    .cornerRadius(10)
                                    .shadow(color: .white, radius: 2, y: 5)
                                
                                Rectangle()
                                    .fill(Color(red: 255/255, green: 0/255, blue: 191/255))
                                    .frame(width: girlLoadingModel.contact.arraySize[girlLoadingModel.currentIndex], height: 10)
                                    .cornerRadius(10)
                                    .offset(x: girlLoadingModel.contact.arrayOffset[girlLoadingModel.currentIndex])
                            }
                        }
                        .offset(y: -70)
                    }
                }
                .onAppear {
                    audioManager.playBackgroundMusic()
                    girlLoadingModel.startTimer()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        girlLoadingModel.currentIndex += 1
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        girlLoadingModel.currentIndex += 1
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        girlLoadingModel.isMenu = true
                    }
                }
                
                NavigationLink(destination: GirlMenuView(),
                               isActive: $girlLoadingModel.isMenu) {}
                    .hidden()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GirlLoadingView()
}

