import SwiftUI

class GirlLoadingViewModel: ObservableObject {
    let contact = GirlLoadingModel()
    @Published var currentIndex = 0
    @Published var isMenu = false
    @Published var index = 0
    @Published var timer: Timer?
    @Published var currentText = "LOADING..."
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.changeText()
        }
    }
    
    func changeText() {
        index -= 1
        if index == -1 {
            index = 2
        }
        currentText = contact.arrayText[index]
    }
    
}
