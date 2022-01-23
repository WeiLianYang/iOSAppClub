//
//  ListTelView.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/22.
//

import SwiftUI

struct ListTelView: View {
    var body: some View {
        // 导航控制器
        NavigationView {
            List(getDataList(), id: \.name) { model in
                // 设置页面 item 点击跳转到详情界面
                NavigationLink(destination: DetailItemView(name: model.name, tel: model.tel)) {
                    RowItemView(data: model)
                }
            }
        }
    }
}

struct ListTelView_Previews: PreviewProvider {
    static var previews: some View {
        ListTelView()
    }
}
