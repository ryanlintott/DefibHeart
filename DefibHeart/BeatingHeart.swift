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
        
        var animation: Animation {
            switch self {
            case .stopped:
                return .easeInOut(duration: 0.2)
            case .oneBeat:
                return .easeInOut(duration: 0.2).delay(0.2).repeatCount(1, autoreverses: true)
            case .regular:
                return .easeInOut(duration: 0.5).delay(0.05).repeatForever(autoreverses: true)
            }
        }
    }
    let rhythm: Rhythm
    
    @State private var expandAmount = 0.0
    
    var body: some View {
        Heart(expandAmount: max(0,expandAmount))
            .fill(Color.heartRed)
//            .onAppear {
//                withAnimation(rhythm.animation) {
//                    expandAmount = 0.1
//                }
//            }
            .onChange(of: rhythm) { newValue in
                withAnimation(.easeInOut(duration: 0.2)) {
                    expandAmount = 0
                }
                withAnimation(newValue.animation.delay(0.2)) {
                    expandAmount = 0.1
                }
            }
    }
}

struct BeatingHeart_Previews: PreviewProvider {
    struct PreviewData: View {
        @State private var rhythm: BeatingHeart.Rhythm = .stopped
        
        var body: some View {
            VStack {
                ZStack {
                    Heart(expandAmount: 0)
                        .allowsHitTesting(false)
                    
                    
                    BeatingHeart(rhythm: rhythm)
                        .opacity(0.5)
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
