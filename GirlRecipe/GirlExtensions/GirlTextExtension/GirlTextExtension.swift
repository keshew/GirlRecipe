import SwiftUI

extension Text {
    func Unlock(size: CGFloat,
                       color: Color = .white,
                       outlineWidth: CGFloat = 1,
                       colorOutline: Color = Color(red: 169/255, green: 2/255, blue: 146/255)) -> some View {
        self.font(.custom("Unlock-Regular", size: size))
            .foregroundColor(color)
            .outlineText(color: colorOutline, width: outlineWidth)
    }
}
