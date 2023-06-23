//
//  ViewModel.swift
//  SaveJournal Api
//
//  Created by Yogesh on 6/23/23.
//

import UIKit

class ViewModel {

    func saveComment(username: String, chapter: String, comment: String, level: Int = 1, completion: @escaping (Data?) -> ()){
        
        let url = URL(string: "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User/SaveJournal")
        
        var urlReq = URLRequest(url: url!)
        urlReq.httpMethod = "POST"
        urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body : [String: Any] = [
            "UserName" : username,
            "ChapterName" : chapter,
            "Comment" : comment,
            "Level" : level
        ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        urlReq.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            
            if let data = data {
                print(String(data: data, encoding: .utf8))
                completion(data)
            }
            else{
                print("Data Error")
                completion(nil)
            }
            
            if let error = error {
                print(error)
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    

}
