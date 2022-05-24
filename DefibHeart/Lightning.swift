//
//  Lightning.swift
//  DefibHeart
//
//  Created by Ryan Lintott on 2022-05-24.
//

import SwiftUI
import ShapeUp

struct Lightning: CornerShape {
    var closed: Bool = false
    var insetAmount: CGFloat = 0
    
    let boltThickness: CGFloat
    
    let endHeight = 0.7
    let spikeHeight = 0.4
    let spikeHalfWidth = 0.2
    let pointOffset = 0.1
    
    func corners(in rect: CGRect) -> [Corner] {
        let midEdge = rect.points(relativeLocations: [
            (0, endHeight),
            (0.5 - spikeHalfWidth, 0.5),
            (0.5 - pointOffset, 0.5 - spikeHeight),
            (0.5 + pointOffset, 0.5 + spikeHeight),
            (0.5 + spikeHalfWidth, 0.5),
            (1, endHeight)
        ]).corners()
        
        let outerEdge = midEdge.inset(by: boltThickness)
        
        return midEdge + outerEdge.dropFirst().dropLast().reversed()
    }
}

struct Lightning_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Lightning(boltThickness: 5)
                .fill(Color.blue)                
            
            Lightning(boltThickness: -5)
                .fill(Color.red)
        }
            .frame(width: 200, height: 200)
    }
}
