import SwiftUI

struct GradientAnimationView: View {
    @State private var start = UnitPoint(x: 0, y: 0)
    @State private var end = UnitPoint(x: 1, y: 1)
    @State private var colors = [Color.pink, Color.purple, Color.blue]
    @State private var input: String = ""
    @State private var isMicrophoneActive = false
    @State private var animationSpeed: Double = 1.5 // New state variable for animation speed
    @State private var isBreathing = false

    var body: some View {
        ZStack {
            // Frost effect background
            VisualEffectBlur()
                .cornerRadius(24)
                .overlay(
                    // Background gradient with blur
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
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
                        TextField("Ask MacGic", text: $input)
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(height: 48)
                            .padding(.horizontal)
                            .textFieldStyle(PlainTextFieldStyle())

                        // Microphone symbol as an image with breathing effect
                        Image(systemName: "mic.fill")
                            .font(.system(size: 20))
                            .padding(.trailing, 10)
                            .foregroundColor(isMicrophoneActive ? .orange : .primary)
                            .opacity(isMicrophoneActive ? (isBreathing ? 1.0 : 0.7) : 1.0)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isMicrophoneActive.toggle()
                                    if isMicrophoneActive {
                                        startBreathingAnimation()
                                    }
                                }
                                if isMicrophoneActive {
                                    // Handle microphone activation
                                    print("Microphone activated")
                                } else {
                                    // Handle microphone deactivation
                                    print("Microphone deactivated")
                                }
                            }
                    }
                    .transition(.opacity)
                )
                .padding(.horizontal)
                .frame(maxWidth: 561)
        }
        .frame(maxWidth: 561, maxHeight: 48)
        .background(Color.clear)
        .cornerRadius(24)
    }

    private func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + animationSpeed) {
            withAnimation(Animation.linear(duration: animationSpeed)) {
                // Randomize the colors with a smooth transition
                colors = [Color.random(), Color.random(), Color.random()]
            }
            startAnimation()
        }
    }

    private func startBreathingAnimation() {
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            isBreathing.toggle()
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
