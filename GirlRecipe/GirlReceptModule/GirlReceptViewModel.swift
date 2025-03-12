import SwiftUI

class GirlReceptViewModel: ObservableObject {
    let contact = GirlReceptModel()
    @Published var currentIndex = 0
    @Published var dragOffset: CGFloat = 0
    @Published var isDragging = false
}
