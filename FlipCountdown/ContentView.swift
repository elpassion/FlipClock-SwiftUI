import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(alignment: .center) {
            FlipView()
        }
    }

}

struct FlipView: View {

    let viewModel = SingleFlipViewModel()
    @State var value: Int = 0

    var body: some View {
        HStack(alignment: .center) {
            SingleFlipView(viewModel: viewModel)
            Button(action: {
                self.viewModel.newText = "\(self.value)"
                self.value += 1
            }) {
                Text("Tap on me")
            }
        }
    }

}

class SingleFlipViewModel: ObservableObject {

    var newText: String? {
        didSet { updateTexts(old: oldValue, new: text) }
    }

    @Published var text: String?
    @Published var oldText: String?

    @Published var animateTop: Bool = false
    @Published var animateBottom: Bool = false

    func updateTexts(old: String?, new: String?) {
        oldText = old
        animateTop = false
        animateBottom = false

        withAnimation(Animation.easeIn(duration: 0.2)) { [weak self] in
            self?.text = new
            self?.animateTop = true
        }

        withAnimation(Animation.easeOut(duration: 0.2).delay(0.2)) {
            self.animateBottom = true
        }
    }

}

struct SingleFlipView: View {

    init(viewModel: SingleFlipViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: SingleFlipViewModel

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(viewModel.newText ?? "")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .fixedSize()
                    .padding(.bottom, -24)
                    .frame(width: 50, height: 30, alignment: .bottom)
                    .padding([.top, .leading, .trailing], 10)
                    .clipped()
                    .background(Color.red)
                Text(viewModel.oldText ?? "")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .fixedSize()
                    .padding(.bottom, -24)
                    .frame(width: 50, height: 30, alignment: .bottom)
                    .padding([.top, .leading, .trailing], 10)
                    .clipped()
                    .background(Color.red)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateTop ? -90 : .zero), axis: (1, 0, 0), anchor: .bottom, perspective: 0.5)
            }
            ZStack {
                Text(viewModel.oldText ?? "")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .fixedSize()
                    .padding(.top, -24)
                    .frame(width: 50, height: 30, alignment: .top)
                    .padding([.bottom, .leading, .trailing], 10)
                    .clipped()
                    .background(Color.green)
                Text(viewModel.newText ?? "")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .fixedSize()
                    .padding(.top, -24)
                    .frame(width: 50, height: 30, alignment: .top)
                    .padding([.bottom, .leading, .trailing], 10)
                    .clipped()
                    .background(Color.green)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateBottom ? .zero : 90), axis: (1, 0, 0), anchor: .top, perspective: 0.5)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
