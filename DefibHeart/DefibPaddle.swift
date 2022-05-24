//
//  DefibPaddle.swift
//  DefibHeart
//
//  Created by Ryan Lintott on 2022-05-23.
//

import ShapeUp
import SwiftUI

struct DefibPaddle: View {
    let size: CGFloat
    
    let shadow = Color.black.opacity(0.2)
    let highlight = Color.white.opacity(0.2)
    
    var body: some View {
        HStack(spacing: 0) {
            Color.defibHandle
                .overlay(
                    LinearGradient(
                        stops: [
                            .init(color: highlight, location: 0),
                            .init(color: .clear, location: 0.2),
                            .init(color: .clear, location: 0.5),
                            .init(color: highlight, location: 0.6),
                            .init(color: .clear, location: 0.75)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ).blendMode(.screen)
                )
                .mask(
                    CornerCustom { rect in
                        rect.points(relativeLocations: [
                            (1, 1),
                            (0.6, 1),
                            (0.6, 0.4),
                            (0.3, 0.4),
                            (0.3, 0.9),
                            (0, 0.85),
                            (0, 0.2),
                            (0.6, 0.2),
                            (0.6, 0),
                            (1, 0)
                        ]).corners(.rounded(radius: .relative(0.3)))
                            .applyingStyle(.rounded(radius: .relative(0.1)), corners: [0,9])
                    }
                )
            .frame(width: size * 0.55)
            
            Rectangle()
                .fill(Color.darkMetal)
                .overlay(LinearGradient(colors: [shadow, .clear, .clear, .clear, shadow], startPoint: .leading, endPoint: .trailing))
                .frame(width: size * 0.06, height: size * 0.8)
            
            Color.lightMetal
                .overlay(LinearGradient(colors: [shadow, .clear, .clear, .clear, shadow], startPoint: .leading, endPoint: .trailing))
                .mask(
                    CornerRectangle()
                        .applyingStyle(.rounded(radius: .relative(0.2)))
                        .applyingStyle(.rounded(radius: .relative(0.5)), shapeCorners: [.topLeft, .bottomLeft])
                )
                .frame(width: size * 0.09)
        }
        .frame(height: size)
    }
    
    
}

struct DefibPaddle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            DefibPaddle(size: 100)
            
            DefibPaddle(size: 100)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
}
