//
//  DragGestureExtension.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 30/04/23.
//

import SwiftUI

extension DragGesture.Value {
    /// Devuelve la velocidad del gesto de arrastre
    var velocity: CGSize {
        let valueMirror = Mirror(reflecting: self)
        
        for valueChild in valueMirror.children {
            if valueChild.label == "velocity" {
                let velocityMirror = Mirror(reflecting: valueChild.value)
                
                for velocityChild in velocityMirror.children {
                    if velocityChild.label == "valuePerSecond" {
                        if let velocity = velocityChild.value as? CGSize {
                            return velocity
                        }
                    }
                }
            }
        }
        
        fatalError("No se puede obtener la velocidad desde \(Self.self)")
    }
}

