//
//  LibraryPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-07.
//
/*
import SwiftUI

struct LibraryPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchName: String = ""
    var searchArea: some View{
        TextField("search area", text: $searchName).textFieldStyle(RoundedBorderTextFieldStyle())
    }
    var body: some View {
        //NavigationView{
        ZStack{
            Image("wall").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading){
                HStack{
                    TextField("search area", text: $searchName).padding(.leading, 29.0).textFieldStyle(RoundedBorderTextFieldStyle())
                //.navigationViewStyle(StackNavigationViewStyle()).navigationBarBackButtonHidden(true)
                    //.navigationBarTitleDisplayMode(.inline)
                    Button("Submit") {}
                        .padding(.trailing, 20.0)}
                BookListVertical(header:strToRead)
                Spacer()
                }
            //}
            
        }
    }
}

struct LibraryPage_Previews: PreviewProvider {
    static var previews: some View {
        LibraryPage()
    }
}*/
