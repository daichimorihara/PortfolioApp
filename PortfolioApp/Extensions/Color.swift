//
//  Color.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/04.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ThemeColor()
}

struct ThemeColor {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondary = Color("SecondaryColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
}
