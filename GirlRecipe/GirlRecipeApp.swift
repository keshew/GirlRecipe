import SwiftUI

@main
struct GirlRecipeApp: App {
    var body: some Scene {
        WindowGroup {
            GirlLoadingView()
                .onAppear() {
                    UserDefaultsManager().firstLaunch()

                }
        }
    }
}
