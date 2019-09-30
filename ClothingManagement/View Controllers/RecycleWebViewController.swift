//
//  RecycleWebViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/18/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import WebKit

class RecycleWebViewController: UIViewController {
    
    var recyclePlace: Recycle?

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
        webViewIsLoading()
        guard let recyclePlace = recyclePlace else { return }
        
        let url = URL(string: "\(recyclePlace.webURL)")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        // TODO: Test this part
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        webViewIsLoading()
    }
    func webViewIsLoading(){
        if webView.isLoading == true {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        webView.stopLoading()

    }
}
