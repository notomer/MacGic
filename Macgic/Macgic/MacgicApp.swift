import SwiftUI

struct MacgicApp: App {
    var body: some Scene {
        WindowGroup {
            GradientAnimationView()
                .background(Color.clear)
                .ignoresSafeArea()
                .onAppear {
                    let window = NSApplication.shared.windows.first
                    window?.styleMask = [.borderless, .fullSizeContentView]
                    window?.isOpaque = false
                    window?.backgroundColor = .clear
                    window?.level = .floating
                }
        }
    }
}
