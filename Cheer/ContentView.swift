//
//  ContentView.swift
//  Cheer
//
//  Created by 宋伟 on 2021/10/7.
//

import SwiftUI

struct ContentView: View {
    @State private var fullText: String = "https://www.baidu.com"
    let collection: Collection
    let webView: WebView
    
    init() {
        collection = Collection()
        webView = WebView(url: .constant("https://www.baidu.com"), collection: collection)
    }
    
    var body: some View {
        VStack {
            webView.frame(width: 0, height: 0)
            
            HStack {
                TextEditor(text: $fullText)
                    .frame(width: 250, height: 50, alignment: .leading)
                
                Spacer()
                
                Button(action: {
                    print("Click the button")
                    self.webView.loadRequest(url: fullText)
                }) {
                    Text("Search")
                }
            }
            
            Text(collection.title).font(.title)
            Text(collection.username)
            Text(collection.content)
            Text(collection.publishedAt)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
