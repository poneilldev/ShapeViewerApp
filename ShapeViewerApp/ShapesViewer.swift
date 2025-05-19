//
//  ShapesViewer.swift
//  ShapeViewerApp
//
//  Created by Paul O'Neill on 5/17/25.
//

import SwiftUI

struct ShapesViewer: View {
	let shapes: [CRShape]
	
	var gridItems: [GridItem] {
		if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .vision {
			return [
				GridItem(.flexible()),
				GridItem(.flexible()),
				GridItem(.flexible()),
				GridItem(.flexible()),
				GridItem(.flexible()),
				GridItem(.flexible()),
			]
		} else {
			return [
				GridItem(.flexible()),
				GridItem(.flexible()),
				GridItem(.flexible())
			]
		}
	}
	
	var body: some View {
		if self.shapes.isEmpty {
			ContentUnavailableView(
				"No shapes added",
				systemImage: "circle.badge.plus.fill",
				description: Text("Add shapes to view.")
			)
		} else {
			ScrollView {
				LazyVGrid(columns: self.gridItems, spacing: 20) {
					ForEach(self.shapes) { shape in
						AnyShape(shape.drawing)
							.foregroundStyle(.teal)
							.aspectRatio(contentMode: .fit)
					}
				}
			}
			.scrollIndicators(.hidden)
			.padding(.horizontal)
		}
	}
}

#Preview("Many Shapes Added") {
	ShapesViewer(
		shapes: [
			.triangle,
			.square,
			.triangle,
			.triangle,
			.triangle,
			.square,
			.circle,
			.triangle,
			.square,
			.triangle,
			.triangle,
			.triangle,
			.square,
			.circle,
			.triangle,
			.square,
			.triangle,
			.triangle,
			.triangle,
			.square,
			.circle,
		]
	)
}

#Preview("Two Shapes Added") {
	ShapesViewer(
		shapes: [
			.triangle,
			.square,
		]
	)
}
