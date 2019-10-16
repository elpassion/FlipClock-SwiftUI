import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(alignment: .center) {
            FlipView()
        }
    }

}

struct FlipView: View {

    var body: some View {
        HStack(alignment: .center) {
            SingleFlipView()
            Button(action: {}) {
                Text("Tap on me")
            }
        }
    }

}

struct SingleFlipView: View {

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("1")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .padding(.bottom, -24)
                    .padding([.top, .leading, .trailing], 5)
                    .clipped()
                    .background(Color.red)
                Text("2")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .padding(.bottom, -24)
                    .padding([.top, .leading, .trailing], 5)
                    .clipped()
                    .background(Color.red)
                    .rotation3DEffect(.init(degrees: 0), axis: (1, 0, 0), anchor: .bottom, perspective: 0.5)
            }
            ZStack {
                Text("2")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .padding(.top, -24)
                    .padding([.bottom, .leading, .trailing], 5)
                    .clipped()
                    .background(Color.green)
                Text("1")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .padding(.top, -24)
                    .padding([.bottom, .leading, .trailing], 5)
                    .clipped()
                    .background(Color.green)
                    .rotation3DEffect(.init(degrees: 0), axis: (1, 0, 0), anchor: .top, perspective: 0.5)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
