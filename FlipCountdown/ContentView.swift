import Combine
import SwiftUI
import Foundation
import UIKit

class ClockViewModel {

    init() {
        setupTimer()
    }

    private(set) lazy var flipViewModels: [SingleFlipViewModel] = {
        (0...5).map { _ in SingleFlipViewModel() }
    }()

    // MARK: - Private

    private func setupTimer() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { [timeFormatter] in timeFormatter.string(from: $0) }
            .removeDuplicates()
            .sink(receiveValue: { [weak self] in self?.setTimeInViewModels(time: $0) })
            .store(in: &cancellables)
    }

    private func setTimeInViewModels(time: String) {
        zip(time, flipViewModels).forEach { number, viewModel in
            viewModel.newText = "\(number)"
        }
    }

    private var cancellables = Set<AnyCancellable>()
    private let timeFormatter = DateFormatter.timeFormatter

}

extension DateFormatter {

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmmss"
        return formatter
    }

}

struct ContentView: View {

    var body: some View {
        VStack(alignment: .center) {
            ClockView()
        }
    }

}

struct ClockView: View {

    let viewModel = ClockViewModel()

    var body: some View {
        HStack(spacing: 15) {
            HStack(spacing: 5) {
                SingleFlipView(viewModel: viewModel.flipViewModels[0])
                SingleFlipView(viewModel: viewModel.flipViewModels[1])
            }
            HStack(spacing: 5) {
                SingleFlipView(viewModel: viewModel.flipViewModels[2])
                SingleFlipView(viewModel: viewModel.flipViewModels[3])
            }
            HStack(spacing: 5) {
                SingleFlipView(viewModel: viewModel.flipViewModels[4])
                SingleFlipView(viewModel: viewModel.flipViewModels[5])
            }
        }
    }

}

class SingleFlipViewModel: ObservableObject, Identifiable {

    var newText: String? {
        didSet { updateTexts(old: oldValue, new: newText) }
    }

    @Published var text: String?
    @Published var oldText: String?

    @Published var animateTop: Bool = false
    @Published var animateBottom: Bool = false

    func updateTexts(old: String?, new: String?) {
        guard old != new else { return }
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
                    .foregroundColor(.textColor)
                    .fixedSize()
                    .padding(.bottom, -20)
                    .frame(width: 15, height: 20, alignment: .bottom)
                    .padding([.top, .leading, .trailing], 10)
                    .clipped()
                    .background(Color.flipBackground)
                    .cornerRadius(4)
                    .padding(.bottom, -4.5)
                    .clipped()
                Text(viewModel.oldText ?? "")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundColor(.textColor)
                    .fixedSize()
                    .padding(.bottom, -20)
                    .frame(width: 15, height: 20, alignment: .bottom)
                    .padding([.top, .leading, .trailing], 10)
                    .clipped()
                    .background(Color.flipBackground)
                    .cornerRadius(4)
                    .padding(.bottom, -4.5)
                    .clipped()
                    .rotation3DEffect(.init(degrees: self.viewModel.animateTop ? -90 : .zero), axis: (1, 0, 0), anchor: .bottom, perspective: 0.5)
            }
            Color.separator
                .frame(width: 35, height: 1)
            ZStack {
                Text(viewModel.oldText ?? "")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundColor(.textColor)
                    .fixedSize()
                    .padding(.top, -20)
                    .frame(width: 15, height: 20, alignment: .top)
                    .padding([.bottom, .leading, .trailing], 10)
                    .clipped()
                    .background(Color.flipBackground)
                    .cornerRadius(4)
                    .padding(.top, -4.5)
                    .clipped()
                Text(viewModel.newText ?? "")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundColor(.textColor)
                    .fixedSize()
                    .padding(.top, -20)
                    .frame(width: 15, height: 20, alignment: .top)
                    .padding([.bottom, .leading, .trailing], 10)
                    .clipped()
                    .background(Color.flipBackground)
                    .cornerRadius(4)
                    .padding(.top, -4.5)
                    .clipped()
                    .rotation3DEffect(.init(degrees: self.viewModel.animateBottom ? .zero : 90), axis: (1, 0, 0), anchor: .top, perspective: 0.5)
            }
        }
    }

}

extension Color {

    static var background: Color {
        Color("background")
    }

    static var flipBackground: Color {
        Color("flip_background")
    }

    static var separator: Color {
        Color("separator")
    }

    static var textColor: Color {
        Color("text_color")
    }

}

//enum Color: String {
//    case background
//    case flipBackground = "flip_background"
//    case separator
//    case textColor = "text_color"
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
