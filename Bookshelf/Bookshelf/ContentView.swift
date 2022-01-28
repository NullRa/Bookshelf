//
//  ContentView.swift
//  Bookshelf
//
//  Created by Apple on 2022/1/28.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if self.selection == 0 {
                    ShelfView()
                } else if self.selection == 1 {
                    Text("Search View")
                }
            }
            Spacer()
            TabBarView(index: $selection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum TabItemType: String {
    case shelf = "書架"
    case search = "搜尋"
    
    var image: Image {
        switch self {
        case .search:
            return Image(systemName: "magnifyingglass")
        case .shelf:
            return Image(systemName: "books.vertical")
        }
    }
    var text: Text {
        return Text(self.rawValue)
    }
}

struct TabItemView: View {
    let tabItemType: TabItemType
    var selected: Bool
    
    var body: some View {
        VStack {
            if selected {
                tabItemType.image
                    .resizable()
                    .frame(width: 25, height: 30)
                    .foregroundColor(Color(red: 22/255, green: 80/255, blue: 142/255))
                    .padding()
                    .background(Color(red: 67/255, green: 154/255, blue: 134/255))
                    .clipShape(Circle())
                    .offset(y: -20)
            } else {
                tabItemType.image
                    .resizable()
                    .frame(width: 25, height: 30)
                    .foregroundColor(Color(red: 67/255, green: 154/255, blue: 134/255))
                tabItemType.text
                    .foregroundColor(Color(red: 22/255, green: 80/255, blue: 142/255))
            }
        }
    }
}

struct TabBarView: View {
    @Binding var index: Int
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                self.index = 0
            } label: {
                TabItemView(tabItemType: .shelf, selected: self.index == 0)
            }
            Spacer()
            Button {
                self.index = 1
            } label: {
                TabItemView(tabItemType: .search, selected: self.index == 1)
            }
            Spacer()
        }
        .background(Color(red: 188/255, green: 216/255, blue: 193/255))
        .animation(.spring(), value: index)
    }
}
