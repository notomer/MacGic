import Cocoa

class CustomWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }

    convenience override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing bufferingType: NSWindow.BackingStoreType, defer flag: Bool) {
        self.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .floating
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    }

    override func mouseDown(with event: NSEvent) {
        self.performDrag(with: event)
    }
}
