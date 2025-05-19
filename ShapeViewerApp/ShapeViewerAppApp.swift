//
//  ShapeViewerAppApp.swift
//  ShapeViewerApp
//
//  Created by Paul O'Neill on 5/17/25.
//

import SwiftUI

@main
struct ShapeViewerAppApp: App {
	@State private var shapeViewerCoordinator = ShapeViewerCoordinator()
	
    var body: some Scene {
        WindowGroup {
			self.shapeViewerCoordinator.contentView
        }
    }
}
