import SwiftUI

struct GradientAnimationView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple, .blue]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 4
                )
                .frame(width: 400, height: 50)
                .opacity(0.5)
                .onAppear {
                    withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                        self.isAnimating = true
                    }
                }
        }
    }
}

struct GradientAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        GradientAnimationView()
    }
}
