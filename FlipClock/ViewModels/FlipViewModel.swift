import Combine
import SwiftUI

class FlipViewModel: ObservableObject, Identifiable {

    var text: String? {
        didSet { updateTexts(old: oldValue, new: text) }
    }

    @Published var newValue: String?
    @Published var oldValue: String?

    @Published var animateTop: Bool = false
    @Published var animateBottom: Bool = false

    func updateTexts(old: String?, new: String?) {
        guard old != new else { return }
        oldValue = old
        animateTop = false
        animateBottom = false

        withAnimation(Animation.easeIn(duration: 0.2)) { [weak self] in
            self?.newValue = new
            self?.animateTop = true
        }

        withAnimation(Animation.easeOut(duration: 0.2).delay(0.2)) { [weak self] in
            self?.animateBottom = true
        }
    }

}
