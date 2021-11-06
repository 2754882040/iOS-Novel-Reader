//
//  DownloadData.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-10-23.
//

import Foundation
import SwiftUI

public enum Result<Data, Error> {
    case success(Data)
    case failure(Error)
}
enum NetworkRequestError: Error {
    case unknow(Data?, URLResponse?)
}

public class DownloadData{
    static func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: URL(string: urlString)!)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let responseData = data, error == nil else {
                    completion(.failure(error ?? NetworkRequestError.unknow(data, response)))
                    return
                }
                completion(.success(responseData))
            }
            task.resume()
    }
}
