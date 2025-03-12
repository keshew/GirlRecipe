import SwiftUI

class GirlVictoryViewModel: ObservableObject {
    let contact = GirlVictoryModel()
    func imageRecipe(level: Int) -> String {
        switch level {
        case 1:
           return GirlImageName.recept1.rawValue
        case 2:
           return GirlImageName.recept2.rawValue
        case 3:
           return GirlImageName.recept3.rawValue
        case 4:
           return GirlImageName.recept4.rawValue
        case 5:
           return GirlImageName.recept5.rawValue
        case 6:
           return GirlImageName.recept6.rawValue
        case 7:
           return GirlImageName.recept7.rawValue
        case 8:
           return GirlImageName.recept8.rawValue
        case 9:
           return GirlImageName.recept9.rawValue
        case 10:
           return GirlImageName.recept10.rawValue
        case 11:
           return GirlImageName.recept11.rawValue
        case 12:
           return GirlImageName.recept12.rawValue
        default:
            return GirlImageName.recept1.rawValue
        }
    }
}
