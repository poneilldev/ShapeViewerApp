//
//  ShapeViewerCoordinatorTests.swift
//  ShapeViewerAppTests
//
//  Created by Paul O'Neill on 5/17/25.
//

import Testing
@testable import ShapeViewerApp

struct ShapeViewerCoordinatorTests {

	@Test("Test adding shapes to the main viewer", arguments: [CRShape.square, .circle, .triangle])
	func addShapeToViewTests(shape: CRShape) async throws {
		let dataModel = ShapeViewerCoordinator.DataModel(shapes: [CRShape.circle, .triangle, .circle])
        let coordinator = ShapeViewerCoordinator(dataModel: dataModel)
		
		coordinator.addShapeToView(shape)
		
		#expect(dataModel.shapes.count == 4)
		#expect(dataModel.shapes.last == shape)
    }
	
	@Test("Remove all shapes")
	func removeAllShapesFromView() async throws {
		let dataModel = ShapeViewerCoordinator.DataModel(shapes: [CRShape.circle, .triangle, .circle])
		let coordinator = ShapeViewerCoordinator(dataModel: dataModel)
		
		coordinator.removeAllShapesFromView()
		
		#expect(dataModel.shapes.isEmpty)
	}
	
	@Test("Remove shapes of specific type", arguments: [CRShape.square, .triangle, .circle])
	func removeShapesOfType(_ shape: CRShape) async throws {
		let dataModel = ShapeViewerCoordinator.DataModel(shapes: [CRShape.square, .triangle, .circle, .square, .triangle, .circle])
		let coordinator = ShapeViewerCoordinator(dataModel: dataModel)
		
		coordinator.removeShapes(of: shape)
		
		#expect(!dataModel.shapes.contains(shape))
	}
}
