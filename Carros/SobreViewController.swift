//
//  SobreViewController.swift
//  Carros
//
//  Created by André Brilho on 26/11/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import UIKit

class SobreViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!

    
    let URL_SOBRE = "http://www.livroiphone.com.br/carros/sobre.htm"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        
        self.title = "Sobre"
        // Do any additional setup after loading the view.
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        
        loading.stopAnimating()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.webView.delegate = self
        self.loading.startAnimating()
        let url = NSURL(string: URL_SOBRE)
        let request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)

        
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        print("Erro ao carregar")
        
    }
    
    
    

}
