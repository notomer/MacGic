import Cocoa

class CustomWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing bufferingType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
        self.isOpaque = false
        self.backgroundColor = .clear
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
        self.toolbar = NSToolbar()
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    }

    override func mouseDown(with event: NSEvent) {
        self.performDrag(with: event)
    }
}
