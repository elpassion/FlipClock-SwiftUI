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

    var body: some View {
        HStack(alignment: .center) {
            SingleFlipView()
        }
    }

}

struct SingleFlipView: View {

    @State var changeTop: Bool = false
    @State var changeBottom: Bool = true

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
                    .onTapGesture {
                        withAnimation(.default) {
                            self.changeTop.toggle()
                        }
                    }
                Text("2")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .padding(.bottom, -24)
                    .padding([.top, .leading, .trailing], 5)
                    .clipped()
                    .background(Color.red)
                    .rotation3DEffect(.init(degrees: changeTop ? -90 : 0), axis: (1, 0, 0), anchor: .bottom, perspective: 0.5)
                    .onTapGesture {
                        withAnimation(.default) {
                            self.changeTop.toggle()
                        }
                    }
            }
            ZStack {
                Text("2")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .padding(.top, -24)
                    .padding([.bottom, .leading, .trailing], 5)
                    .background(Color.green)
                    .onTapGesture {
                        withAnimation(.default) {
                            self.changeBottom.toggle()
                        }
                    }
                Text("1")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .padding(.top, -24)
                    .padding([.bottom, .leading, .trailing], 5)
                    .clipped()
                    .background(Color.green)
                    .rotation3DEffect(.init(degrees: changeBottom ? 90 : 0), axis: (1, 0, 0), anchor: .top, perspective: 0.5)
                    .onTapGesture {
                        withAnimation(.default) {
                            self.changeBottom.toggle()
                        }
                    }
            }
        }
    }


}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
