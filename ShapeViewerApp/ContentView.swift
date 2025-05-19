//
//  ContentView.swift
//  ShapeViewerApp
//
//  Created by Paul O'Neill on 5/17/25.
//

import SwiftUI

struct ContentView: View {
	@Bindable var dataModel: ShapeViewerCoordinator.DataModel
	let perform: (Actions) -> Void
	
	enum Actions {
		case actionButtonPressed(_ actionButton: ShapeButton)
		case loadData
		case clearAllShapes
		case clearShapes(type: CRShape)
		case addShape(CRShape)
		case removeLastInstance(of: CRShape)
		case editCirclesButtonPressed
	}
	
	init(
		dataModel: ShapeViewerCoordinator.DataModel,
		perform: @escaping (Actions) -> Void
	) {
		self.dataModel = dataModel
		self.perform = perform
	}
	
    var body: some View {
		NavigationStack(path: self.$dataModel.navigationPath) {
			switch self.dataModel.viewState {
				case .loading:
					ProgressView()
				case .error(let error):
					ContentUnavailableView(
						"Error",
						systemImage: "exclamationmark.bubble.circle.fill",
						description: Text(error.localizedDescription)
					)
					Button("Retry") {
						self.perform(.loadData)
					}
				case .normal:
					ShapesViewer(shapes: self.dataModel.shapes)
						.toolbar {
							ToolbarItemGroup(placement: .bottomBar) {
								ForEach(self.dataModel.actionButtons) { actionButton in
									Button(actionButton.name) {
										self.perform(.actionButtonPressed(actionButton))
									}
									if actionButton != self.dataModel.actionButtons.last {
										Spacer()
									}
								}
							}
							ToolbarItem(placement: .primaryAction) {
								Button("Edit Circles") {
									self.perform(.editCirclesButtonPressed)
								}
							}
							ToolbarItem(placement: .topBarLeading) {
								Button("Clear All") {
									self.perform(.clearAllShapes)
								}
							}
						}
						.navigationDestination(for: CRShape.self) { shape in
							ShapesViewer(shapes: self.dataModel.shapes.filter { $0.rawValue == shape.rawValue })
								.toolbar {
									ToolbarItemGroup(placement: .bottomBar) {
										Button("Delete All") {
											self.perform(.clearShapes(type: .circle))
										}
										Spacer()
										Button("Add") {
											self.perform(.addShape(.circle))
										}
										Spacer()
										Button("Remove") {
											self.perform(.removeLastInstance(of: .circle))
										}
									}
								}
						}
			}
		}
		.task {
			self.perform(.loadData)
		}
	}
}

#Preview {
	ContentView(dataModel: ShapeViewerCoordinator.DataModel.init(viewState: .error(ShapeViewerCoordinator.ShapeViewerCoordinatorError.shapeNotRecognized)), perform: { _ in })
}
