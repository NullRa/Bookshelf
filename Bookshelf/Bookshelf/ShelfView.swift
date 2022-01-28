//
//  ShelfView.swift
//  Bookshelf
//
//  Created by Apple on 2022/1/28.
//

import SwiftUI
//var testArray:[String] = ["Item 1","Item 2","Item 3","Item 4","Item 5","Item 6","Item 7","Item 8","Item 9","Item 10","Item 11","Item 12","Item 13","Item 14","Item 15","Item 16","Item 17","Item 18","Item 19","Item 20","Item 21"]
var testArray:[String] = ["Item 1","Item 2","Item 3"]

struct ShelfView: View {
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
            }
            
            ScrollView {
                ShelfBodyView()
            }
        }
    }
}

struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView()
    }
}

struct ShelfBodyView: View {
    var body: some View {
        ForEach(0 ..< testArray.count, id:\.self){
            index in
            if isSecondElement(index:index) {
                HStack{
                    Spacer()
                    Text(testArray[index-1])
                        .frame(width: 100)
                    Spacer()
                    Text(testArray[index])
                        .frame(width: 100)
                    Spacer()
                }
                .frame(height: 100)
            }
            
            if self.checkDatasSingle(index: index) {
                HStack{
                    Spacer()
                    Text(testArray[index])
                        .frame(width: 100)
                    Spacer()
                    Text("")
                        .frame(width: 100)
                    Spacer()
                }
                .frame(height: 100)
            }
        }
    }
    func isSecondElement(index:Int)->Bool{
        return index % 2 == 1
    }
    func checkDatasSingle(index:Int)->Bool{
        return (testArray.count-1)%2 == 0 && index == (testArray.count-1)
    }
}
