//
//  ToReadView.swift
//  Libbris
//
//  Created by 阿毛 on 2021-08-12.
//

import SwiftUI

struct ToReadView: View {
    var body: some View {
        
        ScrollView(.vertical){
            VStack(alignment:.leading, spacing:20){
                Text("TO READ").padding()
                VStack(spacing: 116){
                    ForEach(0..<3, id: \.self){ _ in
                        ToReadHorizontalView()
                    }       
                }.padding()
            }
        }
    }
}

struct ToReadView_Previews: PreviewProvider {
    static var previews: some View {
        ToReadView()
    }
}
