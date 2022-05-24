//
//  Heart.swift
//  DefibHeart
//
//  Created by Ryan Lintott on 2022-05-23.
//

import ShapeUp
import SwiftUI

struct Heart: InsettableShapeByProperty {
    var insetAmount: CGFloat = 0
    var expandAmount: CGFloat
    
    var animatableData: Double {
        get { expandAmount }
        set { expandAmount = newValue }
    }
    
    init(expandAmount: CGFloat = 0) {
        self.expandAmount = expandAmount
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let bottom = rect.point(.bottom)
        let top = rect.point(relativeLocation: (0.5, 0.3 - expandAmount))
        let sideControl = rect.point(relativeLocation: (-0.4 - expandAmount, 0.3 - expandAmount))
        let topControl = rect.point(relativeLocation: (0.3,0 - expandAmount))
        let otherSideControl = sideControl.flipped(mirrorLineStart: top, mirrorLineEnd: bottom)
        let otherTopControl = topControl.flipped(mirrorLineStart: top, mirrorLineEnd: bottom)
        
        var points = [
            bottom,
            sideControl,
            topControl,
            top,
            otherTopControl,
            otherSideControl,
            bottom
        ].insetPoints(insetAmount)
        
        path.move(to: points[0])
        path.addCurve(
            to: points[3],
            control1: points[1],
            control2: points[2]
        )
        path.addCurve(
            to: points[0],
            control1: points[4],
            control2: points[5]
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
