//
//  Triangle.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // 頂點
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // 左下角
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // 右下角
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY)) // 回到頂點

        return path
    }
}
