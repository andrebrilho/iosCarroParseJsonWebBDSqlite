//
//  CarroService.swift
//  Carros
//
//  Created by André Brilho on 26/11/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import Foundation

class CarroService{


    

    
    



    class func parserJson(data: NSData) -> Array<Carro>{
        if (data.length == 0){
            return []
        }
        var carros :Array<Carro> = []
        
        let dictOP = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        if let dict = dictOP {
            let jsonCarros: NSDictionary = dict["carros"] as! NSDictionary
            let arrayCarros: NSArray = jsonCarros["carro"] as! NSArray
            for obj:AnyObject in arrayCarros{
                let dict = obj as! NSDictionary
                let carro = Carro()
                carro.nome = dict["nome"] as! String
                carro.desc = dict["desc"] as! String
                carro.url_info = dict["url_info"] as! String
                carro.url_video = dict["url_video"] as! String
                carro.url_foto = dict["url_foto"] as! String
                carro.latitude = dict["latitude"] as! String
                carro.longitude = dict["longitude"] as! String
                carros.append(carro)
            }
            return carros
        } else {
            print("Erro ao ler os dados")
            return carros
        }
    }

    class func getCarrosByTipo(tipo: String, cache: Bool, callback: (carros:Array<Carro>, error:NSError!) -> Void){
        
        
        var db = CarroDB()
        let carros : Array<Carro> = cache ? db.getCarrosByTipo(tipo) : []
        db.close()
        if(carros.count > 0){
            callback(carros: carros, error: nil)
            print("Retornando carros \(tipo) do banco")
            return
        }
        
        
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www.livroiphone.com.br/carros/carros_"+tipo+".json")!
        
        let task = http.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil){
                callback(carros: [], error: error!)
            }else {
                //Parser Json
                let carros = CarroService.parserJson(data!)
                if(carros.count > 0){
                db = CarroDB()
                //Deleta os carros antigos por tipo
                    db.deleteCarrosTipo(tipo)
                    for c in carros {
                    c.tipo = tipo
                    
                        db.save(c)
                    }
                    db.close()
                }
                dispatch_async(dispatch_get_main_queue(),{
                    callback(carros: carros, error: nil)
                })
            }
        })
        task.resume()
        
    }
    

    
    
}
    //Metodo Estatico da classe que retorna um array de carros, o <Carro>, é referente ao retorno da classe Carro com todos os seus parametros
//    class func getCarros()-> Array<Carro>{
//        //Declara um array de carros vazio
//        var carros:Array<Carro> = []
//        for (var i = 0; i < 30; i++){
//            let c = Carro()
//            c.nome = "Ferrari " + String(i)
//            c.desc = "Desc Ferrari " + String(i)
//            c.url_foto = "ferrari.png"
//            //Adiciona o carro no Array
//            carros.append(c)
//        }
//        return carros
//    }
    
    








///////////=---------- XML

//    class func getCarrosByTipoFromFile(tipo:String)-> Array<Carro>{
//        let file = "carros_" + tipo
//        let path = NSBundle.mainBundle().pathForResource(file, ofType: "xml")!
//        let data = NSData(contentsOfFile: path)!
//        if (data.length == 0){
//            print("NSDATA Vazio")
//                return []
//        }
//        let carros = parserXML_SAX(data)
//        return carros
//        }
//    
//    class func parserXML_SAX(data: NSData) -> Array<Carro>{
//        if (data.length == 0){
//            return []
//        }
//        var carros :Array<Carro> = []
//        let xmlParser = NSXMLParser(data:data)
//        let carrosParser = XMLCarroParser()
//        xmlParser.delegate = carrosParser
//        
//        let ok = xmlParser.parse()
//        if(ok){
//            carros = carrosParser.carros
//            let count = carros.count
//            print("Parses, encontrado \(count) elementos")
//        }else{
//            print("Erro Parser")
//        }
//        return carros
//    }
//    
//    
//}