import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var outputText: String = ""
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    VisualEffectView(material: .hudWindow, blendingMode: .withinWindow)
                        .cornerRadius(25)
                        .frame(width: 400, height: 50)
                    
                    GradientAnimationView()

                    TextField("Enter command", text: $inputText, onCommit: {
                        processCommand(command: inputText) { response in
                            outputText = response
                            withAnimation {
                                isExpanded = true
                            }
                        }
                    })
                    .padding()
                    .background(Color.clear)
                    .frame(width: 380, height: 50)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: isExpanded ? .infinity : 50)
            .padding()

            if isExpanded {
                ScrollView {
                    Text(outputText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isExpanded)
            }
        }
        .frame(width: 600, height: isExpanded ? 400 : 50)
        .padding()
        .background(Color.clear)  // Make the background clear to detect clicks
        .onTapGesture {
            if !isExpanded {
                NSApp.keyWindow?.close()
            }
        }
    }

    func processCommand(command: String, completion: @escaping (String) -> Void) {
        let task = Process()
        task.launchPath = "/usr/bin/python3"
        task.arguments = ["-c", """
import sys
sys.path.append('/path/to/your/python/script')
from ai_script import handle_command
response = handle_command('\(command)')
print(response)
"""]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
        if let outputString = String(data: outputData, encoding: .utf8) {
            completion(outputString.trimmingCharacters(in: .whitespacesAndNewlines))
        } else {
            completion("Error processing command")
        }
    }
}

struct VisualEffectView: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
