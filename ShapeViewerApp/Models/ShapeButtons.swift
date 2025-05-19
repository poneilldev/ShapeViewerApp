//
//  ShapeButtons.swift
//  ShapeViewerApp
//
//  Created by Paul O'Neill on 5/17/25.
//

import Foundation

struct ShapeButtons: Codable {
	let buttons: [ShapeButton]
}

struct ShapeButton: Codable, Identifiable, Equatable {
	let name: String
	let drawPath: String
	
	var id: String { self.drawPath }
	
	enum CodingKeys: String, CodingKey {
		case name
		case drawPath = "draw_path"
	}
}
