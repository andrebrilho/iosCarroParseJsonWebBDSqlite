//
//  CarroDB.swift
//  Carros
//
//  Created by André Brilho on 03/12/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import Foundation

class CarroDB{
    //Criando o Banco de dados
    var db: SQLiteHelper
    init(){
    self.db = SQLiteHelper(database: "carros.db")
    
    }

    //Criando Tabela
    func createTable(){
        let sql = "create table if not exists carro (_id integer primary key autoincrement, nome text, desc text, url_foto text, url_info text, url_video text, latitude text, longitude text, tipo text);"
        db.execSql(sql)
    }
    func getCarrosByTipo(tipo: String) -> Array<Carro> {
    
        var carros: Array<Carro> = []
        let stmt = db.query("SELECT * FROM carro where tipo = ?", params:[tipo])
        while (db.nextRow(stmt)){
            let c = Carro()
            c.id            = db.getInt(stmt, index: 0)
            c.nome          = db.getString(stmt, index: 1)
            c.desc          = db.getString(stmt, index: 2)
            c.url_foto      = db.getString(stmt, index: 3)
            c.url_info      = db.getString(stmt, index: 4)
            c.url_video     = db.getString(stmt, index: 5)
            c.latitude      = db.getString(stmt, index: 6)
            c.longitude     = db.getString(stmt, index: 7)
            c.tipo          = db.getString(stmt, index: 8)
            carros.append(c)
        }
        db.closeStatement(stmt)
        return carros
    }
    
    //Salvar um novo carro ou atualizar se já existe
    func save(carro: Carro){
        if(carro.id == 0){
            //Insert
            let sql = "insert or replace into carro (nome, desc, url_foto, url_info, url_video, latitude, longitude, tipo)VALUES (?,?,?,?,?,?,?,?);"
            let params = [carro.nome, carro.desc, carro.url_foto, carro.url_info, carro.url_video, carro.latitude, carro.longitude, carro.tipo]
            let id = db.execSql(sql, params: params as Array<AnyObject>)
            print("Carro \(carro.nome), id: \(id)/\(carro.id) salvo com sucesso")
        } else {
            let sql = "update carro set nome=?, desc=?, url_foto=?, url_info=?, url_video=?, latitude=?, longitude=?, tipo=?) where _id=? VALUES  (?,?,?,?,?,?,?,?);"
            let params = [carro.nome, carro.desc, carro.url_foto, carro.url_info, carro.url_video, carro.latitude, carro.longitude, carro.tipo]
            let id = db.execSql(sql, params: params as Array<AnyObject>)
            print("Carro \(carro.nome), id: \(id)/\(carro.id) Atualizado com sucesso")

        
        }
    }
    
    //Deleta Carro
    func delete(carro: Carro){
        let sql = "delete from carro where _id = ?"
        db.execSql(sql, params: [carro.id])
    }
    
    //Deleta todos os carros do tipo informado
    func deleteCarrosTipo(tipo: String){
        let carros = self.getCarrosByTipo(tipo)
        for c in carros {
            self.delete(c)
        }
    }
    
    func close(){
        self.db.close()
    }
}





























