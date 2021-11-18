//
//  WebView.swift
//  Cheer
//
//  Created by 宋伟 on 2021/10/7.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var url: String
    
    var collection: Collection

    let webview = WKWebView()
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var url: String
        var collection: Collection
        
        init(_ url: String, collection: Collection) {
            self.url = url
            self.collection = collection
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("WebView: navigation finished")
            webView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler: { (value: Any!, error: Error!) in
                self.collection = Collection(url: self.url, html: value as! String)
                print(self.collection)
            })
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        return self.webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        self.webview.navigationDelegate = context.coordinator
        
        let request = URLRequest(url: URL(string: url)!)
        self.webview.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self.url, collection: self.collection)
    }
    
    func loadRequest(url: String) {
        print("Load request: " + url)
        self.url = url
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: .constant(""), collection: Collection())
    }
}
