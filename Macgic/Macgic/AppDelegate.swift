import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: CustomWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the main window using CustomWindow
        window = CustomWindow(contentRect: NSMakeRect(0, 0, 600, 50),
                              styleMask: [.borderless],
                              backing: .buffered, defer: false)
        window.isOpaque = false
        window.backgroundColor = .clear
        window.center()
        window.level = .floating
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
        window.makeKeyAndOrderFront(nil)

        // Set up the content view
        let contentView = ContentView()
        window.contentView = NSHostingView(rootView: contentView)
        
        // Add tap gesture recognizer to close window when clicking outside
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClickOutside))
        clickGesture.buttonMask = 0x1 // left mouse button
        window.contentView?.addGestureRecognizer(clickGesture)
    }
    
    @objc func handleClickOutside() {
        window.close()
    }
}
