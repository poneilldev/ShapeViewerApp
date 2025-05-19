//
//  CRShape.swift
//  ShapeViewerApp
//
//  Created by Paul O'Neill on 5/17/25.
//

import SwiftUI

enum CRShape: String, Identifiable {
	case circle
	case square
	case triangle
	
	var id: UUID { UUID() }
	
	var displayTitle: String {
		switch self {
			case .circle: "Circle"
			case .square: "Square"
			case .triangle: "Triangle"
		}
	}
	
	init?(drawPath: String) {
		switch drawPath {
			case CRShape.circle.rawValue:
				self = .circle
			case CRShape.square.rawValue:
				self = .square
			case CRShape.triangle.rawValue:
				self = .triangle
			default:
				return nil
		}
	}
	
	var drawing: any Shape {
		switch self {
			case .circle: Circle()
			case .square: Rectangle()
			case .triangle: Triangle()
		}
	}
}
