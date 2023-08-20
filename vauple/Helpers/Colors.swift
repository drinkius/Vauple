//
//  File.swift
//  truthordare
//
//  Created by Alexander Telegin on 20.08.2023.
//

import UIKit

class RandomPaleColorGenerator {
    static func generate() -> UIColor {
        let hue = CGFloat.random(in: 0...1) // Random hue value between 0 and 1
        let saturation = CGFloat.random(in: 0.1...0.3) // Random saturation value between 0.1 and 0.3
        let brightness = CGFloat.random(in: 0.8...1.0) // Random brightness value between 0.8 and 1.0

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}
