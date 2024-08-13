import SwiftUI

@main
struct HeadHandsDemo: App {
    @StateObject var appModel: 🥽AppModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup (id:"immersiveWindows") {
            FingerTrackingView()
                .environmentObject(appModel)
        }
        .windowResizability(.contentSize)
        
        ImmersiveSpace(id: "immersiveSpace") {
            🌐RealityView()
                .environmentObject(appModel)
        }
    }
    
    init() {
        🧑HeadTrackingComponent.registerComponent()
        🧑HeadTrackingSystem.registerSystem()
    }
}

