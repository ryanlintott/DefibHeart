//
//  BeatingHeart.swift
//  DefibHeart
//
//  Created by Ryan Lintott on 2022-05-24.
//

import SwiftUI

struct BeatingHeart: View {
    enum Rhythm: String, CaseIterable {
        case stopped
        case oneBeat
        case regular
        
        var startAnimation: Animation {
            switch self {
            case .stopped:
                return .linear(duration: 0)
            case .oneBeat:
                return .easeInOut(duration: 0.5).delay(0.05)
            case .regular:
                return .easeInOut(duration: 0.5).delay(0.05).repeatForever(autoreverses: true).delay(0.2)
            }
        }
        
        var startDuration: CGFloat? {
            switch self {
            case .stopped:
                return 0
            case .oneBeat:
                return 0.525
            case .regular:
                return nil
            }
        }
        
        var stopAnimation: Animation {
            switch self {
            case .stopped:
                return .linear(duration: 0)
            case .oneBeat, .regular:
                return .easeInOut(duration: 0.5)
            }
        }
        
        var stopDuration: CGFloat {
            switch self {
            case .stopped:
                return 0
            case .oneBeat:
                return 0.1
            case .regular:
                return 0.5
            }
        }
    }
    
    let rhythm: Rhythm
    let expandAmount: CGFloat
    
    @State private var expanded = false
    
    func changeRhythm(to newRhythm: Rhythm) {
        if rhythm == newRhythm { return }
        withAnimation(rhythm.stopAnimation) {
            expanded = false
        }
        setRhythm(to: newRhythm, delay: rhythm.stopDuration)
    }
    
    func setRhythm(to newRhythm: Rhythm, delay: CGFloat = 0) {
        withAnimation(newRhythm.startAnimation.delay(delay)) {
            expanded = true
        }
        if let startDuration = newRhythm.startDuration {
            withAnimation(newRhythm.stopAnimation.delay(startDuration)) {
                expanded = false
            }
        }
    }
    
    var body: some View {
        Heart(expandAmount: expanded ? expandAmount : 0)
            .onAppear { setRhythm(to: rhythm) }
            .onChange(of: rhythm, perform: changeRhythm(to:))
    }
}

struct BeatingHeart_Previews: PreviewProvider {
    struct PreviewData: View {
        @State private var rhythm: BeatingHeart.Rhythm = .oneBeat
        
        var body: some View {
            VStack {
                ZStack {
                    BeatingHeart(rhythm: rhythm, expandAmount: 0.1)
                        .opacity(0.5)
                        .foregroundColor(.heartRed)
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 200)
                
                Picker("Rhythm", selection: $rhythm) {
                    ForEach(BeatingHeart.Rhythm.allCases, id: \.self) { rhythm in
                        Text(rhythm.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
        }
    }
    
    static var previews: some View {
        PreviewData()
        
    }
}
