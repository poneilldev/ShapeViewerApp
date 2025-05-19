//
//  ShapeViewerCoordinator.swift
//  ShapeViewerApp
//
//  Created by Paul O'Neill on 5/17/25.
//

import SwiftUI

extension ShapeViewerCoordinator {
	@Observable
	final class DataModel {
		var viewState: ViewState = .loading
		var shapes: [CRShape] = []
		var actionButtons: [ShapeButton] = []
		var selectedShape: CRShape?
		var navigationPath: NavigationPath = .init()
		
		convenience init(shapes: [CRShape]) {
			self.init()
			self.shapes = shapes
		}
		
		convenience init(viewState: ViewState) {
			self.init()
			self.viewState = viewState
		}
	}
}

@Observable
final class ShapeViewerCoordinator {
	let service: ShapeServiceProtocol
	let dataModel: DataModel
	
	init(
		dataModel: DataModel = .init(),
		service: ShapeServiceProtocol = ShapeService()
	) {
		self.service = service
		self.dataModel = dataModel
	}
	
	@ViewBuilder
	var contentView: some View {
		ContentView(dataModel: self.dataModel) { actions in
			switch actions {
				case .actionButtonPressed(let shapeButton):
					self.addShapeToView(shapeButton)
				case .clearAllShapes:
					self.dataModel.shapes.removeAll()
				case .loadData:
					Task {
						await self.fetchShapeActionButtons()
					}
				case .clearShapes(let type):
					self.removeShapes(of: type)
				case .removeLastInstance(let shape):
					if let shapeToRemoveIndex = self.dataModel.shapes.lastIndex(of: shape) {
						self.dataModel.shapes.remove(at: shapeToRemoveIndex)
					}
				case .addShape(let shape):
					self.addShapeToView(shape)
				case .editCirclesButtonPressed:
					self.dataModel.navigationPath.append(CRShape.circle)
			}
		}
	}
	
	@MainActor
	func fetchShapeActionButtons() async {
		do {
			self.dataModel.viewState = .loading
			self.dataModel.actionButtons = try await self.service.fetchShapeButtons()
			self.dataModel.viewState = .normal
		} catch {
			self.dataModel.viewState = .error(error)
		}
	}
	
	func addShapeToView(_ shapeButton: ShapeButton) {
		guard let shape = CRShape(drawPath: shapeButton.drawPath) else {
			self.dataModel.viewState = .error(ShapeViewerCoordinatorError.shapeNotRecognized)
			return
		}
		
		self.addShapeToView(shape)
	}
	
	func addShapeToView(_ shape: CRShape) {
		self.dataModel.shapes.append(shape)
	}
	
	func removeAllShapesFromView() {
		self.dataModel.shapes.removeAll()
	}
	
	func removeShapes(of type: CRShape) {
		self.dataModel.shapes.removeAll(where: { $0.rawValue == type.rawValue })
	}
	
	enum ShapeViewerCoordinatorError: LocalizedError {
		case shapeNotRecognized
		
		var errorDescription: String? {
			switch self {
				case .shapeNotRecognized:
					return "Shape not recognized."
			}
		}
	}
}
