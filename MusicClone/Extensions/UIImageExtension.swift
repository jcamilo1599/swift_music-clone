//
//  UIImageExtension.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 30/04/23.
//

import UIKit

extension UIImage {
    /// Calcula el color promedio de una imagen
    var averageColor: UIColor? {
        // Convierte la imagen a un CIImage
        guard let inputImage = CIImage(image: self) else { return nil }
        
        // Crea un vector que representa el área de la imagen
        let extentVector = CIVector(
            x: inputImage.extent.origin.x,
            y: inputImage.extent.origin.y,
            z: inputImage.extent.size.width,
            w: inputImage.extent.size.height
        )
        
        // Crea un filtro que calcula el color promedio de la imagen
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        // Convierte el resultado del filtro a un bitmap
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        // Convierte el bitmap en un UIColor y lo devuelve
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
