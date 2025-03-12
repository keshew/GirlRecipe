import SwiftUI

class GirlShopViewModel: ObservableObject {
    let contact = GirlShopModel()
    @Published var currentIndex = 0
    @Published var dragOffset: CGFloat = 0
    @Published var isDragging = false
    @Published var again = 1
    @Published var userDef = UserDefaultsManager()
}
