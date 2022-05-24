//
//  DefibHeart.swift
//  DefibHeart
//
//  Created by Ryan Lintott on 2022-05-23.
//

import SwiftUI

struct DefibHeart: View {
    let size: CGFloat
    
    let separationAmount: CGFloat = 0
    let rotationAmount: CGFloat = 1
    let paddleOffset: CGFloat = 0.54
    
    var maxSeparation: CGFloat {
        size * 0.7
    }
    
    let maxRotation: Angle = .degrees(-40)
    
    var body: some View {
        ZStack {
            defibPaddle
            
            defibPaddle
                .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
            
            Heart(expandAmount: 0)
                .fill(Color.heartRed)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: size)
            
            Lightning(boltThickness: size * 0.05)
                .fill(Color.white)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: size * 0.7)
            
            Lightning(boltThickness: size * -0.05)
                .fill(Color.blue)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: size * 0.7)
        }
    }
    
    var defibPaddle: some View {
        DefibPaddle(size: size * 0.5)
            .offset(x: paddleOffset * -size)
            .rotationEffect(maxRotation * rotationAmount)
    }
}

struct DefibHeart_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DefibHeart(size: 50)
            
            DefibHeart(size: 100)
        }
    }
}
