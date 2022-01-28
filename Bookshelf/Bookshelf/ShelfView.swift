//
//  ShelfView.swift
//  Bookshelf
//
//  Created by Apple on 2022/1/28.
//

import SwiftUI

struct ShelfView: View {
    @State var showDetailView = false
    @State private var listType = 0
    @State var selectedItemData: ItemData?// = testItemDatas[0]
    @State var showTypeView = false
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: nil) {
                HStack{
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("編輯")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                }
                
                HStack{
                    Text("書架")
                        .font(.system(.largeTitle, design: .rounded))
                    Spacer()
                }
                .padding(.leading,10)
                
                Divider()
                    .padding([.trailing,.leading],20)
                
                HStack{
                    Button {
                        showTypeView = true
                    } label: {
                        HStack{
                            Image(systemName: "list.bullet")
                                .foregroundColor(.black)
                            Text("全部")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                                .padding(.trailing)
                        }
                    }
                }.padding(.leading,20)
                Divider()
                    .padding([.trailing,.leading],20)
                
                ListTypeSegmentedView(listType: self.$listType)
            }
            
            ZStack {
                if listType == 0 {
                    ShelfByImageBodyView(selectedItemData: $selectedItemData, showDetailView: $showDetailView)
                } else if listType == 1 {
                    ShelfByListBodyView(showDetailView: $showDetailView, selectedItemData: $selectedItemData)
                }
            }
        }
        .sheet(isPresented: $showDetailView) {
            showDetailView = false
            selectedItemData = nil
        } content: {
            if let selectedItemData = selectedItemData {
                ShelfDetailView(itemData: selectedItemData)
            } else {
                Button {
                    showDetailView = false
                } label: {
                    Text("點擊關閉畫面,可惡出錯了")
                }
            }
        }
        .alert("選擇顯示類別", isPresented: $showTypeView) {
            Button {
                showTypeView = false
            } label: {
                Text("全部")
            }
            
            ForEach(testItemDatas.getTypeList().indices, id: \.self){
                index in
                Button {
                    showTypeView = false
                } label: {
                    Text(testItemDatas.getTypeList()[index])
                }
            }

            Button {
                showTypeView = false
            } label: {
                Text("取消")
            }

        }
    }
}

struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView()
    }
}

struct ShelfByImageBodyView: View {
    @Binding var selectedItemData: ItemData?
    @Binding var showDetailView: Bool
    var body: some View {
        ScrollView {
            ForEach(0 ..< testItemDatas.itemDatas.count, id:\.self){
                index in
                if isSecondElement(index:index) {
                    HStack{
                        Spacer()
                        ShelfImageView(itemData: testItemDatas.itemDatas[index-1], showDetailView: $showDetailView, selectedItemData: $selectedItemData)
                        Spacer()
                        ShelfImageView(itemData: testItemDatas.itemDatas[index], showDetailView: $showDetailView, selectedItemData: $selectedItemData)
                        Spacer()
                    }
                }
                
                if self.checkDatasSingle(index: index) {
                    HStack{
                        Spacer()
                        ShelfImageView(itemData: testItemDatas.itemDatas[index], showDetailView: $showDetailView, selectedItemData: $selectedItemData)
                        Spacer()
                        ShelfImageView(itemData: nil, showDetailView: $showDetailView, selectedItemData: $selectedItemData)
                        Spacer()
                    }
                }
            }
        }
    }
    func isSecondElement(index:Int)->Bool{
        return index % 2 == 1
    }
    func checkDatasSingle(index:Int)->Bool{
        return (testItemDatas.itemDatas.count-1)%2 == 0 && index == (testItemDatas.itemDatas.count-1)
    }
}

struct ShelfByListBodyView: View {
    @Binding var showDetailView: Bool
    @Binding var selectedItemData: ItemData?
    var body: some View {
        List(testItemDatas.itemDatas.indices, id: \.self){
            index in
            Text(testItemDatas.itemDatas[index].title)
                .onTapGesture {
                    showDetailView = true
                    selectedItemData = testItemDatas.itemDatas[index]
                }
        }
        .listStyle(.grouped)
    }
}

struct ListTypeSegmentedView: View {
    @Binding var listType: Int
    var body: some View {
        HStack {
            Spacer()
            Picker("segmentedPicker", selection: $listType) {
                Text("圖表").tag(0)
                Text("清單").tag(1)
            }
            .pickerStyle(.segmented)
            .frame(width: 200)
            .padding(.trailing,15)
        }
    }
}

struct ShelfImageView: View {
    var itemData: ItemData?
    @Binding var showDetailView: Bool
    @Binding var selectedItemData: ItemData?
    var body: some View {
        if let itemData = itemData {
            VStack{
                Image(systemName: itemData.image)
                    .resizable()
                    .padding(10)
                VStack(alignment:.leading){
                    HStack {
                        Text("title: \(itemData.title)")
                        Spacer()
                    }
                    HStack {
                        Text("評價: \(itemData.praise)")
                        Spacer()
                    }
                    HStack {
                        Text("進度: \(itemData.processing)")
                        Spacer()
                    }
                    HStack {
                        Text("標籤: \(itemData.getTagsString())")
                        Spacer()
                    }
                }
                .padding(.bottom, 5)
                .padding(.leading, 10)
            }
            .frame(width: (UIScreen.main.bounds.width-60)/2, height: UIScreen.main.bounds.height/3)
            .background(Color(red: 230/255, green: 222/255, blue: 193/255))
            .cornerRadius(20)
            .onTapGesture {
                selectedItemData = itemData
                showDetailView = true
            }
        } else {
            Text("No Info")
                .frame(width: (UIScreen.main.bounds.width-60)/2, height: UIScreen.main.bounds.height/3)
                .background(Color(red: 230/255, green: 222/255, blue: 193/255))
                .cornerRadius(20)
        }
    }
}

struct ShelfDetailView: View {
    @Environment(\.dismiss) var dismiss
    var itemData: ItemData
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Image(systemName: itemData.image)
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    HStack(){
                        Text("Title: \(itemData.title)")
                        Spacer()
                    }
                    .padding(.leading, 10)
                    HStack(){
                        Text("進度: \(itemData.processing)")
                        Spacer()
                    }
                    .padding(.leading,10)
                    
                    HStack(){
                        Text("評價: \(itemData.praise)")
                        Spacer()
                    }
                    .padding(.leading,10)
                    Spacer()
                    HStack(){
                        Text("心得: ")
                        Spacer()
                    }
                    .padding(.leading,10)
                }
            }
            Button {
                dismiss()
            } label: {
                Text("關閉畫面")
            }
        }
    }
}
