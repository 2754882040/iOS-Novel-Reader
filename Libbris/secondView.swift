//
//  secondView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-03.
//

import SwiftUI

struct secondView: View {
    @Environment(\.presentationMode) var mode
    var body: some View {
       
            Text("Hello, World123!").navigationBarItems(
                trailing:
                    NavigationLink(destination: secondView(),label:{Text("second View")}))
        Button(action: {self.mode.wrappedValue.dismiss()}, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
        
    }
}

struct secondView_Previews: PreviewProvider {
    static var previews: some View {
        secondView()
    }
}
