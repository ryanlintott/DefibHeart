//
//  ContentView.swift
//  DefibHeart
//
//  Created by Ryan Lintott on 2022-05-23.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn: Bool = false
    
    var body: some View {
        DefibHeart(isOn: isOn, size: 100)
            .onTapGesture {
                isOn.toggle()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
