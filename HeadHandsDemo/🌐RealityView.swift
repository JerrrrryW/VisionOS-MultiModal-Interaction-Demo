import SwiftUI
import RealityKit
import ARKit

struct 🌐RealityView: View {
    @EnvironmentObject var model: 🥽AppModel
    
    @State var sceneContent: Entity?
    @State var contentHolder: (any RealityViewContentProtocol)?
    
    @Environment(\.openWindow) private var openWindow
    
    // Fingertip joints to display
    let fingertipJoints = [
        "leftThumbTip", "leftIndexTip", "leftMiddleTip", "leftRingTip", "leftPinkyTip",
        "rightThumbTip", "rightIndexTip", "rightMiddleTip", "rightRingTip", "rightPinkyTip"
    ]

    var body: some View {
        RealityView { content in
            content.add(self.model.rootEntity)
            self.model.setUpChildEntities()
            contentHolder = content;
            
            
        }  update: { (content) in
            // call a function in AppModel that recognizes custom hand gestures
            let customGestures = self.model.detectCustomTaps()
            let allJointPositions = self.model.getAllFingerJointPositions()

        }
        .background {
            🛠️MenuTop()
                .environmentObject(self.model)
        }
        .onAppear(){
            openWindow(id: "immersiveWindows")
        }
        .task { self.model.run() }
        .task { self.model.observeAuthorizationStatus() }
        .upperLimbVisibility(.hidden) // Hide hands so we can display dots over the joints
    }
}
