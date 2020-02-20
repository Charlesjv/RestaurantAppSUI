//
//  getCartData.swift
//  RestaurantApp
//
//  Created by Charles JV on 2020-02-18.
//  Copyright © 2020 Charles JV. All rights reserved.
//

import Foundation
import Firebase
import SDWebImageSwiftUI

class getCartData: ObservableObject{
            @Published var datas = [cart]()
    
    init(){
        let db = Firestore.firestore()
        db.collection("cart").addSnapshotListener { (snap, err) in
            if err != nil{
                print((err?.localizedDescription))
            }
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    let id = i.document.documentID
                    let name = i.document.get("item") as! String
                    let  quantity = i.document.get("quantity") as! NSNumber
                    let pic = i.document.get("pic") as! String

                    self.datas.append(cart(id: id, name: name, quantity: quantity, pic: pic))
                }
                
                if i.type == .modified{
                    let id = i.document.documentID
                    let quantity = i.document.get("quantity") as! NSNumber
                    
                    for j in 0 ..< self.datas.count{
                        if self.datas[j].id == id {
                            self.datas[j].quantity == quantity
                        }
                    }
                }
                
            }
            
        }
        }
    }
    





