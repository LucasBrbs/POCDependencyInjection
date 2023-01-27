//
//  APICaller.swift
//  APIKIT
//
//  Created by Lucas Barbosa de Oliveira on 24/01/23.
//

import Foundation

public class APICaller{
    public static let shared = APICaller()

    public init(){

    }

    public func fetchCourseNames(completion: @escaping ([String]) -> Void){
        guard let url = URL(string: "https://catfact.ninja/fact") else {
            completion([])

            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error ==  nil else {
                return
            }
            //decode
            do {
                guard let json = try JSONSerialization.jsonObject(with: data,options: .allowFragments) as? [[String:String]] else {
                    completion([])
                    return
                }
                let facts: [String] = json.compactMap({$0["fact"]})
                completion(facts)
            }
            catch{
                completion([])
            }
        }
        task.resume()
    }
}
