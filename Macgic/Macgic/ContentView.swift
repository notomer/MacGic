import SwiftUI

struct ContentView: View {
    var body: some View {
        GradientAnimationView()
            .frame(width: 600, height: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
