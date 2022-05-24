//
//  DefibHeart.swift
//  DefibHeart
//
//  Created by Ryan Lintott on 2022-05-23.
//

import SwiftUI

struct DefibHeart: View {
    enum Keyframe: Int, CaseIterable, Comparable {
        static func < (lhs: DefibHeart.Keyframe, rhs: DefibHeart.Keyframe) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        
        case start
        case clear
        case contact
        case zap
        case zapDone
        case beating
        case end
        
        var rhythm: BeatingHeart.Rhythm {
            switch self {
            case .start, .clear, .contact, .zap, .zapDone:
                return .stopped
            case .beating, .end:
                return .regular
            }
        }
        
        var paddleRotation: Angle {
            switch self {
            case .start, .end:
                return .zero
            case .clear, .beating:
                return .degrees(-25)
            case .contact, .zap, .zapDone:
                return .degrees(-35)
            }
        }
        
        var paddleOffset: CGPoint {
            switch self {
            case .start, .end:
                return CGPoint(x: 0, y: 0.1)
            case .clear, .beating:
                return CGPoint(x: -0.8, y: 0)
            case .contact, .zap, .zapDone:
                return CGPoint(x: -0.54, y: -0.05)
            }
        }
        
        var duration: CGFloat {
            switch self {
            case .start:
                return .zero
            case .clear:
                return 0.2
            case .contact:
                return 0.2
            case .zap:
                return 0.5
            case .zapDone:
                return 0.1
            case .beating:
                return 0.4
            case .end:
                return 0.4
            }
        }
        
        var delay: CGFloat {
            guard rawValue > 0 else { return .zero }
            
            return (0..<rawValue)
                .compactMap { Self.init(rawValue: $0)?.duration }
                .reduce(into: 0.0, +=)
        }
        
        var animation: Animation {
            .timingCurve(0.6, 0, 0.4, 1, duration: duration)
        }
    }
    
    let isOn: Bool
    let size: CGFloat
    
    @State private var keyframe: Keyframe = .start
    
//    let separationAmount: CGFloat = 0
//    let rotationAmount: CGFloat = 1
//    let paddleOffset: CGFloat = 0.54
//
//    var maxSeparation: CGFloat {
//        size * 0.7
//    }
//
//    let maxRotation: Angle = .degrees(-40)
    
    func startAnimation() {
        for key in Keyframe.allCases.dropFirst() {
            print("Key: \(key) Duration: \(key.duration) Delay \(key.delay)")
            withAnimation(key.animation.delay(key.delay)) {
                keyframe = key
            }
        }
    }
    
    func stopAnimation() {
        let key = Keyframe.start
        withAnimation(key.animation) {
            keyframe = key
        }
    }
    
    func toggle(isOn: Bool) {
        isOn ? startAnimation() : stopAnimation()
    }
    
    var lightningGradient: LinearGradient {
        LinearGradient(stops: [
            .init(color: .clear, location: 0),
            .init(color: .white, location: 0.01),
            .init(color: .white, location: 0.99),
            .init(color: .clear, location: 1)
        ], startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        ZStack {
            defibPaddle
            
            defibPaddle
                .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
            
            ZStack {
                Heart(expandAmount: keyframe.rhythm == .regular ? 0.1 : 0)
                        .fill(keyframe >= .zap ? Color.heartRed : Color.white)
                    
                Heart(expandAmount: keyframe.rhythm == .regular ? 0.1 : 0)
                        .strokeBorder(Color.heartRed, lineWidth: 3)
            }
            .animation(keyframe == .beating ? .easeInOut(duration: 0.5).delay(0.05).repeatForever().delay(keyframe.delay) : .default, value: keyframe.rhythm)
            .foregroundColor(.heartRed)
            .aspectRatio(1, contentMode: .fit)
            .frame(width: size)
            
            if keyframe >= . contact {
            ZStack {
                Color.clear
                    .overlay {
                        lightningGradient
                            .offset(x: size * (keyframe >= .zap ? 1 : -1))
                    }
                    .mask(
                        Lightning(boltThickness: size * 0.03)
                    )
                
                Color.clear
                    .overlay {
                        lightningGradient
                            .offset(x: size * (keyframe >= .zap ? -1 : 1))
                    }
                    .mask(
                        Lightning(boltThickness: size * -0.03)
                    )
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(width: size * 0.7)
            }
        }
        .onChange(of: isOn, perform: toggle(isOn:))
    }
    
    var defibPaddle: some View {
        DefibPaddle(size: size * 0.5)
            .offset(x: keyframe.paddleOffset.x * size, y: keyframe.paddleOffset.y * size)
            .rotationEffect(keyframe.paddleRotation)
    }
}

struct DefibHeart_Previews: PreviewProvider {
    struct PreviewData: View {
        @State private var isOn: Bool = false
        
        var body: some View {
            DefibHeart(isOn: isOn, size: 100)
                .onTapGesture {
                    isOn.toggle()
                }
        }
    }
    
    static var previews: some View {
        PreviewData()
    }
}
