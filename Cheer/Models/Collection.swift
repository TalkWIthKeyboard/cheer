//
//  Collection.swift
//  Cheer
//
//  Created by 宋伟 on 2021/10/8.
//

import SwiftUI
import Fuzi

struct Collection: Hashable {
    var url: String = ""
    var title: String = ""
    var username: String = ""
    var platform: Platform = Platform.XIAO_HONG_SHU
    var content: String = ""
    // TODO: date
    var publishedAt: String = ""
    
    enum Platform: Hashable {
        case XIAO_HONG_SHU
    }
    
    init() {
        
    }
    
    init(url: String, html: String) {
        do {
            self.url = url
            
            let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
            
            self.platform = Platform.XIAO_HONG_SHU
            
            if let titleNode = doc.firstChild(xpath: "//div[@class=\"note\"]/h1[@class=\"title\"]") {
                self.title = titleNode.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            if let usernameNode = doc.firstChild(xpath: "//div[@class=\"nickname-info has-poi\"]/div[@class=\"nickname\"]/a") {
                self.username = usernameNode.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            for contentNode in doc.xpath("//div[@class=\"note\"]/main[@class=\"content\"]/div[1]/div[@class=\"content\"]/p") {
                self.content += contentNode.stringValue.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
            }
            
            if let publishedAtNode = doc.firstChild(xpath: "//div[@class=\"note\"]/div[@class=\"publish-date\"]/span") {
                self.publishedAt = publishedAtNode.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } catch let error {
            print(error)
        }
    }
}
