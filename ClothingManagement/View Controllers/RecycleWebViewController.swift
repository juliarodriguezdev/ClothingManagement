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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let recyclePlace = recyclePlace else { return }
        
        let url = URL(string: "\(recyclePlace.webURL)")
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        webView.stopLoading()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
