import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.title = "App"
        statusItem.button?.action = #selector(toggleAppWindow)

        // Show the main app window
        showMainAppWindow()
    }

    @objc func toggleAppWindow() {
        if NSApp.isActive {
            NSApp.hide(nil)
        } else {
            NSApp.activate(ignoringOtherApps: true)
        }
    }

    func showMainAppWindow() {
        let mainStoryboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let mainWindowController = mainStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("MainWindowController")) as! NSWindowController
        mainWindowController.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
