//
//  ShelfView.swift
//  Bookshelf
//
//  Created by Apple on 2022/1/28.
//

import SwiftUI

struct ShelfView: View {
    @State var showView = false
    @State private var listType = 0
    @State var selectedItemData: ItemData?// = testItemDatas[0]
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
                    ShelfByImageBodyView(selectedItemData: $selectedItemData, showView: $showView)
                } else if listType == 1 {
                    ShelfByListBodyView(showView: $showView)
                }
            }
        }
        .sheet(isPresented: $showView) {
            showView = false
            selectedItemData = nil
        } content: {
            if let selectedItemData = selectedItemData {
                ShelfDetailView(itemData: selectedItemData)
            } else {
                Button {
                    showView = false
                } label: {
                    Text("點擊關閉畫面,可惡出錯了")
                }
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
    @Binding var showView: Bool
    var body: some View {
        ScrollView {
            ForEach(0 ..< testItemDatas.count, id:\.self){
                index in
                if isSecondElement(index:index) {
                    HStack{
                        Spacer()
                        ShelfImageView(itemData: testItemDatas[index-1], showView: $showView, selectedItemData: $selectedItemData)
                        Spacer()
                        ShelfImageView(itemData: testItemDatas[index], showView: $showView, selectedItemData: $selectedItemData)
                        Spacer()
                    }
                }
                
                if self.checkDatasSingle(index: index) {
                    HStack{
                        Spacer()
                        ShelfImageView(itemData: testItemDatas[index], showView: $showView, selectedItemData: $selectedItemData)
                        Spacer()
                        ShelfImageView(itemData: nil, showView: $showView, selectedItemData: $selectedItemData)
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
        return (testItemDatas.count-1)%2 == 0 && index == (testItemDatas.count-1)
    }
}

struct ShelfByListBodyView: View {
    @Binding var showView: Bool
//    @Binding var selectedItemData: ItemData?
    var body: some View {
        List(testItemDatas.indices, id: \.self){
            index in
            Text(testItemDatas[index].title)
                .onTapGesture {
                    showView = true
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
    @Binding var showView: Bool
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
                showView = true
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
    var itemData: ItemData
    var body: some View {
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
    }
}
