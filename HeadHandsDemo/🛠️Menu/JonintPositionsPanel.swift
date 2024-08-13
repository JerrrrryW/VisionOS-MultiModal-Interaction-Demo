import SwiftUI

struct JointPositionsPanel: View {
    // Mock data for testing
    @EnvironmentObject var model: 🥽AppModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("All Joint Positions")
                .font(.title2)
                .padding(.bottom, 10)
            
//            let allJointPositions = model.getAllFingerJointPositions()
            let jointPositions = [
                "Thumb": SIMD3(x: 0.1, y: 0.2, z: 0.3),
                "Index": SIMD3(x: 0.4, y: 0.5, z: 0.6),
                "Middle": SIMD3(x: 0.7, y: 0.8, z: 0.9),
                "Ring": SIMD3(x: 1.0, y: 1.1, z: 1.2),
                "Pinky": SIMD3(x: 1.3, y: 1.4, z: 1.5)
            ]
            
            // Generate the view using the mock data
            ForEach(jointPositions.sorted(by: { $0.key < $1.key }), id: \.key) { jointName, position in
                HStack {
                    Text(jointName)
                        .font(.body)
                    Spacer()
                    Text("(\(position.x), \(position.y), \(position.z))")
                        .font(.body.monospaced())
                        .foregroundColor(.primary)
                }
                .padding(5)
                .background()
            }
        }
        .padding(30)
        .frame(maxWidth: 600)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview(windowStyle: .automatic) {
    JointPositionsPanel()
}
