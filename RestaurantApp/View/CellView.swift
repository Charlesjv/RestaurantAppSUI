//
//  CellView.swift
//  RestaurantApp
//
//  Created by Charles JV on 2020-02-18.
//  Copyright © 2020 Charles JV. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct CellView: View{
    var data: category
    
    @State var show = false
    var body: some View{
        VStack{
                                       AnimatedImage(url:URL(string: data.pic)).resizable().frame(height: 270)
                                  HStack{
                                           VStack(alignment: .leading){
                                            Text(data.name).font(.title).fontWeight(.heavy)
                                               
                                               Text(data.price).font(.body).fontWeight(.heavy)
                                           }
                                           
                                     Spacer()
                                    Button(action: {
                                        self.show.toggle()
                                           }) {
                                               Image(systemName: "arrow.right").font(.body).foregroundColor(.black).padding(14)
                                               
                                               
                                               }.background(Color.yellow).clipShape(Circle())
                                           
                                           
                                           
                                  }.padding(.horizontal).padding(.bottom, 6)
                                       
        }.background(Color.white).cornerRadius(20).sheet(isPresented: self.$show) {
            OrderView(data: self.data)
        }
    }
}


