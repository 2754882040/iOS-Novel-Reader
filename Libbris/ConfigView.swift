//
//  ConfigView.swift
//  Libbris
//
//  Created by 王沛洋 on 2021-08-23.
//

import SwiftUI

struct ConfigView: View {
    @State var showInfo:Bool = false
    var body: some View {
        VStack
        {
            Button(action: {print("Language button pressed...")}) {Text("Change Language").padding()};
            
                Button(action: {
                    print("Config button pressed...")
                    self.showInfo = true
                }) {
                    Text("Information").padding()
                    NavigationLink(
                        destination: InfoView().navigationBarTitle(Text("Information")),
                        isActive: $showInfo,
                        label: {}
                    )
                }.accessibilityIdentifier("InfoButton");
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}


