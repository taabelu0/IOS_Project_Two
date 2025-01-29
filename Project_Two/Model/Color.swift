//
//  Color.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//

import SwiftUI
import UIKit

extension Color {
    /// Extrahiert den Hue-Wert aus einer SwiftUI Color
    func getHSBComponents() -> (hue: Double, saturation: Double, brightness: Double)? {
        let uiColor = UIColor(self) // Konvertiert SwiftUI Color zu UIColor
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return (Double(hue), Double(saturation), Double(brightness))
        }
        return nil
    }
}
