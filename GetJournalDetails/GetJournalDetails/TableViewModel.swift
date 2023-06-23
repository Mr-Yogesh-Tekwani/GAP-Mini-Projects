//
//  ViewModel.swift
//  GetJournalDetails
//
//  Created by Yogesh on 6/23/23.
//

import Foundation
import UIKit

class TableViewModel {
    
    func getJournalUrl(UserName: String) -> URL {
        let getJournalLink = "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User/GetJournal?UserName=" + UserName
        let url = URL(string: getJournalLink)
        return url ?? URL(string: "google.com")!
    }
    
    func getDetails(username: String, completion: @escaping ([ResultModel]?) -> ())  {
        var allData : [ResultModel] = []
        
        let url = getJournalUrl(UserName: username)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                print(String(data: data, encoding: .utf8))
                let decoder = JSONDecoder()
                let ans = try? decoder.decode([ResultModel].self, from: data)
                print("Decoding successfull !")
                allData = ans ?? []
                completion(allData)
            }
            else{
                completion(nil)
            }
            if let error = error {
                print(error)
                print(error.localizedDescription)
                completion(nil)
            }
        }
        task.resume()
    }
    
}



