//
//  RowItemView.swift
//  iOSAppDemo
//
//  Created by WilliamYang on 2022/1/21.
//

import SwiftUI

struct RowItemView: View {
    var data: ItemData
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image("demo")
                .resizable()
                .frame(width: 70, height: 70, alignment: .leading)
            VStack(alignment: .leading, spacing: 10) {
                Text(self.data.name).bold().font(Font.system(size: 26))
                Text(self.data.tel).font(Font.system(size: 20))
            }
            Spacer()
        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

struct RowItemView_Previews: PreviewProvider {
    static var previews: some View {
        // id 是行标识字段，要保证唯一性
        List(getDataList(), id: \.name) { model in
            RowItemView(data: model)
        }
    }
}

struct ItemData {
    var name: String
    var tel: String
}

func getDataList() -> [ItemData] {
    var array = Array<ItemData>()
    for index in 0...20 {
        let data = ItemData(name: "name\(index)", tel: "188-8888-8888")
        array.append(data)
    }
    return array
}

let dataList = [
    ItemData(name: "Tom", tel: "136-1234-5678"),
    ItemData(name: "David", tel: "166-2134-9876"),
    ItemData(name: "LiLei", tel: "188-9876-5432"),
    ItemData(name: "HanMei", tel: "188-9876-5432"),
    ItemData(name: "William", tel: "188-8888-8888")
]
