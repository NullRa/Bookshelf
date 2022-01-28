//
//  ShelfView.swift
//  Bookshelf
//
//  Created by Apple on 2022/1/28.
//

import SwiftUI
var titleArray:[String] = ["Item 1","Item 2","Item 3","Item 4","Item 5","Item 6","Item 7","Item 8","Item 9","Item 10","Item 11","Item 12","Item 13","Item 14","Item 15","Item 16","Item 17","Item 18","Item 19","Item 20","Item 21"]
//var titleArray:[String] = ["Item 1","Item 2","Item 3"]

struct ShelfView: View {
    @State var showView = false
    @State private var listType = 0
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
                    ShelfByImageBodyView(showView: $showView)
                } else if listType == 1 {
                    ShelfByListBodyView()
                }
            }
        }
        .sheet(isPresented: $showView) {
            showView = false
        } content: {
            Button {
                showView = false
            } label: {
                Text("Hi and Bye !")
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
    @Binding var showView: Bool
    var body: some View {
        ScrollView {
            ForEach(0 ..< titleArray.count, id:\.self){
                index in
                if isSecondElement(index:index) {
                    HStack{
                        Spacer()
                        ShelfImageView(title: titleArray[index-1], showView: $showView)
                        Spacer()
                        ShelfImageView(title: titleArray[index], showView: $showView)
                        Spacer()
                    }
                }
                
                if self.checkDatasSingle(index: index) {
                    HStack{
                        Spacer()
                        ShelfImageView(title: titleArray[index], showView: $showView)
                        Spacer()
                        ShelfImageView(title: "", showView: $showView)
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
        return (titleArray.count-1)%2 == 0 && index == (titleArray.count-1)
    }
}

struct ShelfByListBodyView: View {
    var body: some View {
        List(titleArray, id:\.self){
            title in
            Text(title)
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
    var title:String
    @Binding var showView: Bool
    var body: some View {
        VStack{
            Image(systemName: "house")
                .resizable()
                .padding(10)
            VStack(alignment:.leading){
                HStack {
                    Text(title)
                    Spacer()
                }
                Text("評價")
                Text("進度")
                Text("標籤")
            }
            .padding(.bottom, 5)
            .padding(.leading, 10)
        }
        .frame(width: (UIScreen.main.bounds.width-60)/2, height: UIScreen.main.bounds.height/3)
        .background(.blue)
        .cornerRadius(20)
        .onTapGesture {
            showView = true
        }
    }
}
