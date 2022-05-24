//
//  Heart.swift
//  DefibHeart
//
//  Created by Ryan Lintott on 2022-05-23.
//

import ShapeUp
import SwiftUI

struct Heart: Shape {
    var insetAmount: CGFloat = 0
    var closed: Bool = true
    var expandAmount: CGFloat
    
    var animatableData: Double {
        get { expandAmount }
        set { expandAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let bottom = rect.point(.bottom)
        let top = rect.point(relativeLocation: (0.5, 0.3 - expandAmount))
        let sideControl = rect.point(relativeLocation: (-0.4 - expandAmount, 0.3 - expandAmount))
        let topControl = rect.point(relativeLocation: (0.3,0 - expandAmount))
        
        path.move(to: bottom)
        path.addCurve(
            to: top,
            control1: sideControl,
            control2: topControl
        )
        path.addCurve(
            to: bottom,
            control1: topControl.flipped(mirrorLineStart: top, mirrorLineEnd: bottom),
            control2: sideControl.flipped(mirrorLineStart: top, mirrorLineEnd: bottom)
        )
        
        path.closeSubpath()
        
        return path
    }
}

struct Heart_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Heart(expandAmount: 0.1)
                .fill(Color.blue)
            
            Heart(expandAmount: 0)
                .fill(Color.heartRed.opacity(0.5))
        }
            .aspectRatio(1, contentMode: .fit)
    }
}
