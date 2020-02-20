//
//  getCartData.swift
//  RestaurantApp
//
//  Created by Charles JV on 2020-02-18.
//  Copyright © 2020 Charles JV. All rights reserved.
//
import SwiftUI
import SDWebImageSwiftUI
import Firebase

class getCategoriesData: ObservableObject{
    @Published var datas = [category]()
    
    init(){
        let db = Firestore.firestore()
        db.collection("categories").addSnapshotListener { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let price = i.document.get("price") as! String
                let pic = i.document.get("pic") as! String
                
                self.datas.append( category(id: id, name: name, price: price, pic: pic ))
            }
        }
        
        
    }
}
