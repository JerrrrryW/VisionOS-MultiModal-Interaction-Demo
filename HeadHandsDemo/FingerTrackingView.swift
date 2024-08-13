import SwiftUI

struct FingerTrackingView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @EnvironmentObject var model: 🥽AppModel

    @State private var leftHandJointPositions: [String: SIMD3<Float>] = [:]
    @State private var rightHandJointPositions: [String: SIMD3<Float>] = [:]
    
    // 用于切换显示模式的布尔变量
    @State private var showAllJoints: Bool = false

    var body: some View {
        VStack {
            Text("Gesture Tracking Data")
                .font(.title)
                .padding()
            
            // 切换按钮
            Button(showAllJoints ? "Show Fingertips Only" : "Show All Joints") {
                showAllJoints.toggle()
                updateHandJointPositions() // 切换显示模式时更新显示的数据
            }
            .padding()

            Spacer()
            HStack {
                Spacer()
                // 左手指尖坐标
                VStack(alignment: .leading) {
                    Text("Left Hand")
                        .font(.headline)
                    ForEach(leftHandJointPositions.keys.sorted(), id: \.self) { key in
                        if let position = leftHandJointPositions[key] {
                            HStack {
                                Text("\(key):")
                                Spacer()
                                Text("x: \(formatCoordinate(position.x)), y: \(formatCoordinate(position.y)), z: \(formatCoordinate(position.z))")
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: 450)
  
                Spacer()
                // 右手指尖坐标
                VStack(alignment: .leading) {
                    Text("Right Hand")
                        .font(.headline)
                    ForEach(rightHandJointPositions.keys.sorted(), id: \.self) { key in
                        if let position = rightHandJointPositions[key] {
                            HStack {
                                Text("\(key):")
                                Spacer()
                                Text("x: \(formatCoordinate(position.x)), y: \(formatCoordinate(position.y)), z: \(formatCoordinate(position.z))")
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: 450)
                Spacer()
            }
            .padding(20)
            .background()
            Spacer()
            Button("Dismiss") {
                Task {
                    dismissWindow()
                }
            }
            .padding()
        }
        .glassBackgroundEffect()
        .onReceive(model.$latestHandTracking) { _ in
            updateHandJointPositions()
        }
    }

    // 更新手部关节位置
    private func updateHandJointPositions() {
        let allPositions = model.getAllFingerJointPositions()

        if showAllJoints {
            leftHandJointPositions = allPositions.filter { $0.key.hasPrefix("left") }
            rightHandJointPositions = allPositions.filter { $0.key.hasPrefix("right") }
        } else {
            leftHandJointPositions = allPositions.filter { $0.key.hasPrefix("left") && $0.key.contains("Tip") }
            rightHandJointPositions = allPositions.filter { $0.key.hasPrefix("right") && $0.key.contains("Tip") }
        }
    }

    // 格式化坐标保留两位小数
    private func formatCoordinate(_ value: Float) -> String {
        return String(format: "%.2f", value)
    }
}

// 添加 Preview
#Preview {
    FingerTrackingView()
        .environmentObject(🥽AppModel()) // 为预览注入一个 AppModel 实例
}
