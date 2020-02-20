//
//  Home.swift
//  RestaurantApp
//
//  Created by Charles JV on 2020-02-18.
//  Copyright © 2020 Charles JV. All rights reserved.
//

import SwiftUI

struct Home:View{
    
    @ObservedObject var categories = getCategoriesData()
    
    var body: some View{
        VStack{
            if self.categories.datas.count != 0 {
                ScrollView(.vertical, showsIndicators: false)
                {
                    VStack(spacing:15){
                        ForEach(self.categories.datas){i in
                            
                            CellView(data: i)
                           
                        }
                    }.padding()
                }.background(Color("Color").edgesIgnoringSafeArea(.all))
            }
            else{
                Loader()
            }
        }
    }
}

struct Home_Previews: PreviewProvider{
    static var previews:some View{
        Home()
    }
}


struct Loader:UIViewRepresentable{
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
}
