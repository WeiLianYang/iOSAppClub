//
//  SwiftUIView.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/21.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 15) {
            Text("Hello, World!")
                .foregroundColor(Color.blue)
                .underline()
                .font(Font.system(size: 26))

            Text("Hello, William")
                .foregroundColor(Color.black)
                .underline()
                .font(Font.system(size: 36))

            TextLabel()
            
            Image("demo")
                .frame(width: 200, height: 200, alignment: .center)
                .clipShape(Circle())
                .shadow(radius: 20)

        }
        .padding(EdgeInsets(top: 50, leading: 10, bottom: 50, trailing: 10))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}


struct TextLabel: UIViewRepresentable {
    
    // 返回指定的 UIKit 组件
    func makeUIView(context: Context) -> UILabel {
        UILabel(frame: .zero)
    }
    
    // 组件更新时被调用
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = "This is custom UILabel"
    }
}
