import SwiftUI

struct ContentView: View {
//     使用@Environment属性包装器获取系统环境变量openImmersiveSpace和dismissWindow的引用
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissWindow) var dismissWindow

    var body: some View { 
        // 使用NavigationStack包裹主视图，以提供导航功能
        NavigationStack {
            VStack {
                Spacer() // 添加弹性空间，将内容推到垂直中心位置
                HStack(spacing: 28) {
                    // 第一个图像视图，使用resizable和aspectRatio调整图像大小和比例
                    Image(.graph1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .clipShape(.rect(cornerRadius: 16, style: .continuous))
                    // 第二个图像视图，配置与第一个图像视图相同
                    Image(.graph2)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .clipShape(.rect(cornerRadius: 16, style: .continuous))
                }
                .padding(.horizontal, 8) // 为图像视图添加水平内边距
                Spacer() // 再次添加弹性空间
                // 按钮视图，点击时会触发异步任务
                Button {
                    Task {
                        // 打开ID为"immersiveSpace"的沉浸式空间
                        await self.openImmersiveSpace(id: "immersiveSpace")
                        // 关闭当前窗口
                        self.dismissWindow()
                    }
                } label: {
                    // 按钮的文本标签，设置字体大小和内边距
                    Text("Start")
                        .font(.largeTitle)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 4)
                }
                Spacer() // 再次添加弹性空间
            }
            .navigationTitle("VisionOS: Hand + Head Tracking Demo") // 设置导航栏标题
        }
        .frame(width: 700, height: 450) // 设置整个视图的宽度和高度
    }
}

#Preview {
    ContentView()
}
