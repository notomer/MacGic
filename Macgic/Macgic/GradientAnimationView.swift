import SwiftUI

struct GradientAnimationView: View {
    @State private var start = UnitPoint(x: 0, y: 0)
    @State private var end = UnitPoint(x: 1, y: 1)
    @State private var colors = [Color.pink, Color.purple, Color.blue]
    @State private var textInput = ""
    @State private var isMicrophoneActive = false

    var body: some View {
        ZStack {
            // Frost effect background
            VisualEffectBlur()
                .cornerRadius(24)
                .overlay(
                    // Background gradient with blur
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
                        .animation(Animation.linear(duration: 2.5).repeatForever(autoreverses: false))
                        .onAppear {
                            startAnimation()
                        }
                        .mask(RoundedRectangle(cornerRadius: 24)) // Mask gradient to stay within rounded rectangle
                        .blur(radius: 30) // Adding more blur effect
                )
            
            // Foreground with rounded rectangle and border
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.clear)
                .frame(height: 48) // --box-height: 48px;
                .overlay(
                    HStack {
                        TextField("Message ChatGPT", text: $textInput)
                            .font(.system(.body, design: .monospaced))
                            .frame(height: 48)
                            .padding(.horizontal)
                            .textFieldStyle(PlainTextFieldStyle())

                        // Microphone button
                        Image(systemName: "mic.fill")
                            .font(.system(size: 20))
                            .padding(.trailing, 10)
                            .foregroundColor(isMicrophoneActive ? .orange : .primary)
                            .onTapGesture {
                                isMicrophoneActive.toggle()
                            }
                    }
                )
                .padding(.horizontal)
                .frame(maxWidth: 561)
        }
        .frame(maxWidth: 561, maxHeight: 48)
        .background(Color.clear)
        .cornerRadius(24)
        .overlay(
            DragHandle()
                .frame(width: 561, height: 48)
                .background(Color.clear)
                .cornerRadius(24)
        )
    }

    private func startAnimation() {
        withAnimation(Animation.linear(duration: 2.5).repeatForever(autoreverses: false)) {
            // Randomize the start and end points
            start = UnitPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1))
            end = UnitPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(Animation.linear(duration: 2.5)) {
                // Randomize the colors with a smooth transition
                colors = [Color.random(), Color.random(), Color.random()]
            }
            startAnimation()
        }
    }
}

// Extension to generate random colors
extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}

// VisualEffectBlur struct
struct VisualEffectBlur: NSViewRepresentable {
    var material: NSVisualEffectView.Material = .hudWindow
    var blendingMode: NSVisualEffectView.BlendingMode = .withinWindow

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

// DragHandle struct
struct DragHandle: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        let gesture = NSPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(gesture:)))
        view.addGestureRecognizer(gesture)
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        @objc func handlePan(gesture: NSPanGestureRecognizer) {
            guard let window = gesture.view?.window else { return }
            let translation = gesture.translation(in: window.contentView)
            window.setFrameOrigin(NSPoint(x: window.frame.origin.x + translation.x, y: window.frame.origin.y - translation.y))
            gesture.setTranslation(.zero, in: window.contentView)
        }
    }
}
