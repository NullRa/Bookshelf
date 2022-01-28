//
//  ItemData.swift
//  Bookshelf
//
//  Created by Apple on 2022/1/28.
//

import Foundation
struct ItemData {
    var title: String
    var image: String
    var praise: Int
    var processing: String
    var tags: [String]
    var type: String
    
    func getTagsString() -> String {
        var tagsString = ""
        for tag in tags {
            tagsString = tagsString + " " + tag
        }
        return tagsString
    }
}

var testItemDatas = TestItemDatas()
//: [ItemData] = [
//    ItemData(title: "house", image: "house", praise: 1, processing: "完成", tags: ["喜劇","校園"], type: "書籍"),
//    ItemData(title: "bag", image: "bag", praise: 2, processing: "進行中", tags: ["喜劇","鬼怪"], type: "電影"),
//    ItemData(title: "gamecontroller", image: "gamecontroller", praise: 5, processing: "進行中", tags: ["懸疑","校園"], type: "書籍"),
//    ItemData(title: "bolt", image: "bolt", praise: 3, processing: "未讀", tags: ["科幻","日劇"], type: "影集"),
//    ItemData(title: "tortoise", image: "tortoise", praise: 1, processing: "棄坑", tags: ["喜劇","校園","美劇"], type: "影集"),
//]

struct TestItemDatas {
    var itemDatas: [ItemData] = [
        ItemData(title: "house", image: "house", praise: 1, processing: "完成", tags: ["喜劇","校園"], type: "書籍"),
        ItemData(title: "bag", image: "bag", praise: 2, processing: "進行中", tags: ["喜劇","鬼怪"], type: "電影"),
        ItemData(title: "gamecontroller", image: "gamecontroller", praise: 5, processing: "進行中", tags: ["懸疑","校園"], type: "書籍"),
        ItemData(title: "bolt", image: "bolt", praise: 3, processing: "未讀", tags: ["科幻","日劇"], type: "影集"),
        ItemData(title: "tortoise", image: "tortoise", praise: 1, processing: "棄坑", tags: ["喜劇","校園","美劇"], type: "影集"),
    ]
    
    func getTypeList() -> [String] {
        var typeList: [String] = []
        for itemData in itemDatas {
            if typeList.contains(itemData.type) == false {
                typeList.append(itemData.type)
            }
        }
        return typeList
    }
}
