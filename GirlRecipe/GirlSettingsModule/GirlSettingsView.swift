import SwiftUI

struct GirlSettingsView: View {
    @StateObject var girlSettingsModel = GirlSettingsViewModel()
    @ObservedObject var audioManager = AudioManager.shared
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
                        
                        Text("SETTINGS")
                            .Unlock(size: 60)
                        
                        Spacer(minLength: geometry.size.height * 0.1375)
                        
                        ZStack {
                            Image(.settingsBack)
                                .resizable()
                                .frame(width: geometry.size.width * 0.865, height: geometry.size.height * 0.275)
                            
                            VStack {
                                Text("MUSIC")
                                    .Unlock(size: 25)
                                
                                HStack {
                                    Button(action: {
                                        if audioManager.backgroundVolume > 0 {
                                            audioManager.backgroundVolume -= 0.1
                                        }
                                    }) {
                                        Image(.minus)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.075, height: geometry.size.width * 0.075)
                                    }
                                    
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .fill(.black)
                                            .frame(width: geometry.size.width * 0.5625, height: geometry.size.height * 0.02)
                                            .opacity(0.6)
                                            .cornerRadius(10)
                                            .shadow(color: .white, radius: 2, y: 5)
                                        
                                        Rectangle()
                                            .fill(Color(red: 255/255, green: 0/255, blue: 191/255))
                                            .frame(width: CGFloat(audioManager.backgroundVolume) * geometry.size.width * 0.54, height: 10)
                                            .cornerRadius(10)
                                            .offset(x: 4)
                                    }
                                    
                                    Button(action: {
                                        if audioManager.backgroundVolume < 1 {
                                            audioManager.backgroundVolume += 0.1
                                        }
                                    }) {
                                        Image(.plus)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.075, height: geometry.size.width * 0.075)
                                    }
                                }
                                
                                Text("SOUND")
                                    .Unlock(size: 25)
                                
                                HStack {
                                    Button(action: {
                                        if audioManager.soundEffectVolume > 0 {
                                            audioManager.soundEffectVolume -= 0.1
                                        }
                                    }) {
                                        Image(.minus)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.075, height: geometry.size.width * 0.075)
                                    }
                                    
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .fill(.black)
                                            .frame(width: geometry.size.width * 0.5625, height: geometry.size.height * 0.02)
                                            .opacity(0.6)
                                            .cornerRadius(10)
                                            .shadow(color: .white, radius: 2, y: 5)
                                        
                                        Rectangle()
                                            .fill(Color(red: 255/255, green: 0/255, blue: 191/255))
                                            .frame(width: CGFloat(audioManager.soundEffectVolume) * geometry.size.width * 0.54, height: 10)
                                            .cornerRadius(10)
                                            .offset(x: 4)
                                    }
                                    
                                    Button(action: {
                                        if audioManager.soundEffectVolume < 1 {
                                            audioManager.soundEffectVolume += 0.1
                                        }
                                    }) {
                                        Image(.plus)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.075, height: geometry.size.width * 0.075)
                                    }
                                }
                            }
                            
                            Button(action: {
                                UserDefaultsManager().saveVolumeSettings(backgroundVolume: audioManager.backgroundVolume,
                                                                         soundEffectVolume: audioManager.soundEffectVolume)
                            }) {
                                ZStack {
                                    Image(.blueButton)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.445, height: geometry.size.height * 0.08875)
                                    
                                    Text("SAVE")
                                        .Unlock(size: 25)
                                }
                            }
                            .offset(y: geometry.size.height * 0.15)
                        }
                    }
                }
            }
            .onAppear {
                let (backgroundVolume, soundEffectVolume) = UserDefaultsManager().loadVolumeSettings()
                audioManager.backgroundVolume = backgroundVolume
                audioManager.soundEffectVolume = soundEffectVolume
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GirlSettingsView()
}
    
