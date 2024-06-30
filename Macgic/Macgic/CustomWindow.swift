import Cocoa

class CustomWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }

    convenience init() {
        self.init(contentRect: NSRect(x: 0, y: 0, width: 561, height: 48),
                  styleMask: [.borderless, .fullSizeContentView],
                  backing: .buffered, defer: false)
        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .floating
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    }

    override func mouseDown(with event: NSEvent) {
        let pointInScreen = NSEvent.mouseLocation
        if !self.frame.contains(pointInScreen) {
            self.close()
        }
    }
}
