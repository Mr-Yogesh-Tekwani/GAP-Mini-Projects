//
//  ViewControllerViewModel.swift
//  ApiPractice
//
//  Created by Yogesh on 6/22/23.
//

import Foundation


func createNewUser(username: String, password: String, completion: @escaping (Data?) -> ()){
    let urlString = "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User/UserLogin"
    
    let url = URL(string: urlString)
    
    var urlReq = URLRequest(url: url!)
    urlReq.httpMethod = "POST"
    
    let body = [
        "UserName" : username,
        "Password" : password
    ]
    
    let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
    
    urlReq.httpBody = bodyData
    urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: urlReq){ (data, response, error) in
        if let data = data {
            let strData = String(data: data, encoding: .utf8)
            print(strData)
            completion(data)
        }
        else{
            completion(nil)
        }
        
        if let error = error {
            print(error)
        }
    }
    task.resume()
    
    
}
