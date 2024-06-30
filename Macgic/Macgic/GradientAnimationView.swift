import SwiftUI

struct GradientAnimationView: View {
    @State private var start = UnitPoint(x: 0, y: 0)
    @State private var end = UnitPoint(x: 1, y: 1)
    
    var body: some View {
        ZStack {
            // Background gradient with blur
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple, Color.blue]), startPoint: start, endPoint: end)
                .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
                .onAppear {
                    withAnimation {
                        start = UnitPoint(x: 1, y: 1)
                        end = UnitPoint(x: 0, y: 0)
                    }
                }
                .blur(radius: 30) // Adding more blur effect

            // Frost effect
            VisualEffectBlur()
                .cornerRadius(24)
            
            // Foreground with rounded rectangle and border
            RoundedRectangle(cornerRadius: 24, style: .continuous) // --border-radius: calc(var(--box-height) / 2)
                .fill(Color.clear)
                .frame(height: 48) // --box-height: 48px;
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.5), Color.purple.opacity(0.5), Color.blue.opacity(0.5)]), startPoint: .leading, endPoint: .trailing), lineWidth: 2) // --border-width: 2px
                        .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
                )
                .overlay(
                    TextField("Ask Siri...", text: .constant(""))
                        .font(.system(.body, design: .monospaced))
                        .frame(height: 48) // --box-height: 48px
                        .padding(.horizontal)
                        .textFieldStyle(PlainTextFieldStyle())
                )
                .padding(.horizontal)
                .frame(maxWidth: 561) // max-width: 561px
        }
        .frame(maxWidth: 561, maxHeight: 48)
    }
}

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
