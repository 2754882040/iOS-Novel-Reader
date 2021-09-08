//
//  SwiftUIView.swift
//  Libbris
//
//  Created by 阿毛 on 2021-09-08.
//

import SwiftUI

struct MoreButton: View {
    @ObservedObject var listdata = getData()
    var body: some View {
        List(0..<listdata.data.count, id:\.self){i in
            Text(self.listdata.data[i].id)
        }
    }
}

class getData: ObservableObject{
    @Published var data = [Doc]()
    @Published var count = 1
    
    init() {
        updateData()
    }
    
    func updateData(){
        let url = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/1/chapters" 
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){ (data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            do{
                let json = try JSONDecoder().decode(Detail.self, from: data!)
                
                let oldData = self.data
                
                DispatchQueue.main.async {
                    self.data = oldData + json.response.docs
                }
    
            }
            catch{
                print(String(describing:error))
            }
        }.resume()
    }
}

struct Detail: Decodable{
    var response: Response
}

struct Response: Decodable{
    var docs: [Doc]
}

struct Doc: Decodable {
    var id: String
    var authorName: String
    var bookUrlName: String
    var cover: String
    var lastChapterTitle: String
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MoreButton()
    }
}
