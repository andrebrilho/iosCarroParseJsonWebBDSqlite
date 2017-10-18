//
//  ListaCarrosViewController.swift
//  Carros
//
//  Created by André Brilho on 26/11/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import UIKit

class ListaCarrosViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    var carros:Array<Carro> = []
    //var carros: Carro[]?
    var tipo = "classicos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.title = "Carros"
        
        let xib = UINib(nibName: "CarroCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        //self.carros = CarroService.getCarros()
       // self.carros = CarroService.getCarrosByTipoFromFile("esportivos")
        
        self.automaticallyAdjustsScrollViewInsets = false
        

        let btAtualizar = UIBarButtonItem(title: "Atualizar", style: UIBarButtonItemStyle.Plain, target: self, action: "atualizar")
        self.navigationItem.rightBarButtonItem = btAtualizar
     
        let idx = Prefs.getInt("tipoIdx")
        let s = Prefs.getString("tipoString")
        if(s != nil) {
            // Como a String é opcional precisamos testar antes
            self.tipo = s
        }
        // Atualiza o índice no segment control
        self.segmentControl.selectedSegmentIndex = idx

        
        
    }
    
    func atualizar(){
        buscarCarros(false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.buscarCarros(true)
       print("VALIDAR")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.carros.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "cell"
        let linha = indexPath.row
        let carro = self.carros[linha]
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellID)! as! CarroCell
        cell.cellNome.text = carro.nome
        cell.cellDesc.text = carro.desc
        //cell.cellImg.image = UIImage(named: carro.url_foto)
//        let data = NSData(contentsOfURL: NSURL(string: carro.url_foto)!)!
//        cell.cellImg.image = UIImage(data: data)
        cell.cellImg.setUrl(carro.url_foto)
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let linha = indexPath.row
        let carro = self.carros[linha]
        
        
        //Alerta.alerta("Selecionou o Carro " + carro.nome, viewController: self)
        
        
        let vc = DetalhesCarrosViewController(nibName: "DetalhesCarrosViewController", bundle: nil)
        vc.carro = carro
        self.navigationController!.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func segmentControl(sender: AnyObject) {
        
        
        let idx = sender.selectedSegmentIndex
        switch (idx) {
        case 0:
            self.tipo = "classicos"
            print("CLicou Classicos")
            
        case 1:
            self.tipo = "esportivos"
            print("CLicou Esportivos")
            
        default:
            self.tipo = "luxo"
            print("CLicou Luxo")
            
        }
        
        Prefs.setInt(idx, chave: "tipoIdx")
        Prefs.setString(tipo, chave: "tipoString")
        
        self.buscarCarros(true)
    }
    
//    func buscarCarros(){
//        self.carros = CarroService.getCarrosByTipoFromFile(tipo)
//        self.tableView.reloadData()
//    
//    }
    func buscarCarros(cache: Bool){
        ActivityIndicator.startAnimating()
        CarroService.getCarrosByTipo(tipo, cache:cache) { (carros, error) in
            if (error != nil){
                self.ActivityIndicator.stopAnimating()
                Alerta.alerta("Erro: " + error.localizedDescription, viewController: self)
            }else {
                    self.carros = carros
                    self.tableView.reloadData()
                    self.ActivityIndicator.stopAnimating()
            }
        }
        
    }
    
}
