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
    var tag: [String]
    var type: String
}

var testItemDatas: [ItemData] = [
    ItemData(title: "house", image: "house", praise: 1, processing: "完成", tag: ["喜劇","校園"], type: "書籍"),
    ItemData(title: "bag", image: "bag", praise: 2, processing: "進行中", tag: ["喜劇","鬼怪"], type: "電影"),
    ItemData(title: "gamecontroller", image: "gamecontroller", praise: 5, processing: "進行中", tag: ["懸疑","校園"], type: "書籍"),
    ItemData(title: "bolt", image: "bolt", praise: 3, processing: "未讀", tag: ["科幻","日劇"], type: "影集"),
    ItemData(title: "tortoise", image: "tortoise", praise: 1, processing: "棄坑", tag: ["喜劇","校園","美劇"], type: "影集"),
]
