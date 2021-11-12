//
//  ImageLoader.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-11-10.
//

import Foundation

class ImageLoader: ObservableObject {
    init(url: String) {
        refresh(url: url)
    }
    init() {}
    var data = Data()
    var state = LoadState.loading
    func refresh(url: String) {
        state = LoadState.loading
        let urlWithoutSpace: String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "badlink"
        print(urlWithoutSpace)
        guard let parsedURL = URL(string: urlWithoutSpace)
        else {
            self.state = .failure
            return }
        URLSession.shared.dataTask(with: parsedURL) { data, _, _ in
           if let data = data, data.count > 0 {
               self.data = data
               self.state = .success
           } else {
               self.state = .failure
           }
           DispatchQueue.main.async {
               self.objectWillChange.send()
           }
        }.resume()
   }
}
