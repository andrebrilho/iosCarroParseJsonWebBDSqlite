//
//  DetalhesCarrosViewController.swift
//  Carros
//
//  Created by André Brilho on 26/11/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import UIKit

class DetalhesCarrosViewController: UIViewController {

    @IBOutlet var img:DownloadImageView!
    @IBOutlet var tDesc:UITextView!
    var carro:Carro?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let c = carro {
        
            self.title = c.nome
            self.tDesc.text = c.desc
            //let img = UIImage(named: c.url_foto)
            //self.img.image = img
            //let data = NSData(contentsOfURL: NSURL(string: c.url_foto)!)!
            self.img.setUrl(c.url_foto)
            
            let btDeletar = UIBarButtonItem(title: "Deletar", style: UIBarButtonItemStyle.Plain, target: self, action: "onClickDeletar")
            self.navigationItem.rightBarButtonItem = btDeletar
            
        
        }
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickDeletar(){
        
        let alert = UIAlertController(title: "Confirma ?", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: { (UIAlertAction) in
            self.deletar()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .Destructive, handler: { (UIAlertAction) in
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    func deletar(){
        let db = CarroDB()
        db.delete(self.carro!)
        Alerta.alerta("Carro excluido com sucesso", viewController: self, action: {(UIAlertAction) -> Void in
            self.goBack()
        })
    }
    
    func goBack(){
        self.navigationController!.popViewControllerAnimated(true)
    
    }
    
    @IBAction func AbrirMapa(sender: AnyObject) {
        
        let vc = MapViewController(nibName:"MapViewController", bundle:nil)
        vc.carro = self.carro
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    

}
