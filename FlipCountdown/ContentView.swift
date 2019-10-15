//
//  ContentView.swift
//  FlipCountdown
//
//  Created by Maciej Gomółka on 14/10/2019.
//  Copyright © 2019 Maciej Gomółka. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(alignment: .center) {
            FlipView()
        }
    }

}

struct FlipView: View {

    @State var animateTop: Bool = false
    @State var animateBottom: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            SingleFlipView(animateTop: $animateTop, animateBottom: $animateBottom)
            Button(action: {
                withAnimation(.easeIn(duration: 0.5)) {
                    self.animateTop.toggle()
                }

                withAnimation(Animation.easeOut(duration: 0.5).delay(0.5)) {
                    self.animateBottom.toggle()
                }
            }) {
                Text("Tap on me")
            }
        }
    }

}

struct SingleFlipView: View {

    init(animateTop: Binding<Bool>, animateBottom: Binding<Bool>) {
        self._animateTop = animateTop
        self._animateBottom = animateBottom
    }

    @Binding var animateTop: Bool
    @Binding var animateBottom: Bool

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
                    .rotation3DEffect(.init(degrees: animateTop ? -90 : 0), axis: (1, 0, 0), anchor: .bottom, perspective: 0.5)
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
                    .rotation3DEffect(.init(degrees: animateBottom ? 0 : 90), axis: (1, 0, 0), anchor: .top, perspective: 0.5)
            }
        }
    }


}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
