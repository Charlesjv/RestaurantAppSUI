//
//  CartView.swift
//  RestaurantApp
//
//  Created by Charles JV on 2020-02-18.
//  Copyright © 2020 Charles JV. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct CartView: View{
    
    @ObservedObject var cartData = getCartData()
    var body: some View{
        VStack(alignment: .leading){
            Text(self.cartData.datas.count  != 0 ?   "Items in the Cart" : "No Items in the Cart").padding([.top,.leading])
            
            if self.cartData.datas.count != 0 {
                List{
                    
                    ForEach(self.cartData.datas){ i in
                        HStack(spacing: 15){
                                               AnimatedImage(url: URL(string: i.pic)).resizable().frame(width: 55, height: 55).cornerRadius(15)
                                               VStack(alignment: .leading){
                                                   Text(i.name)
                                                   Text("\(i.quantity)")
                                                   
                                               }
                        }.onTapGesture {
                            UIApplication.shared.windows.last?.rootViewController?.present(textFieldAlertView(id: i.id), animated: true, completion: nil)
                        }
                        
                    }.onDelete { (IndexSet) in
                        
                        let db = Firestore.firestore()
                        db.collection("cart").document(self.cartData.datas[IndexSet.last!].id).delete { (err) in
                            
                            if err != nil {
                                print((err?.localizedDescription))
                                return
                            }
                            
                            self.cartData.datas.remove(atOffsets: IndexSet)
                            
                        }
                    }
                    
                   
                }
            }
        }.frame(width: UIScreen.main.bounds.width - 110, height: UIScreen.main.bounds.height - 350).background(Color.white).cornerRadius(25)
    }
 
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}


func textFieldAlertView(id: String) -> UIAlertController{
    
    let alert = UIAlertController(title: "Update", message: "Enter the Quantity", preferredStyle: .alert )
    
    alert.addTextField { (txt) in
        
        txt.placeholder = "Enter the quantity"
        txt.keyboardType = .numberPad
        
    }
    
    let update = UIAlertAction(title: "Update", style: .default) { (_) in
        
        let db = Firestore.firestore()
        
        let value = alert.textFields![0].text!
        
        db.collection("cart").document(id).updateData(["quantity": Int(value)! ]){
            (err) in
            
            if err != nil{
                print((err?.localizedDescription))
                return
                
            }
            
        }
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    alert.addAction(update)
    alert.addAction(cancel)
    return alert
}
