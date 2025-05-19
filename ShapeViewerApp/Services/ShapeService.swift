//
//  ShapeService.swift
//  ShapeViewerApp
//
//  Created by Paul O'Neill on 5/17/25.
//

import Foundation

protocol ShapeServiceProtocol {
	/// Fetch the shape button for adding shapes to the viewer.
	func fetchShapeButtons() async throws -> [ShapeButton]
}

struct ShapeService: ShapeServiceProtocol {
	static let endpoint = "http://staticcontent.cricut.com/static/test/shapes_001.json"
	
	let session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	func fetchShapeButtons() async throws -> [ShapeButton] {
		let endpoint = URL(string: Self.endpoint)!
		let (data, _) = try await self.session.data(from: endpoint)
		return try JSONDecoder().decode(ShapeButtons.self, from: data).buttons
	}
}
