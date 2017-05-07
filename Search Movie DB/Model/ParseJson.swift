//
//  ParseJson.swift
//  Search Movie DB
//
//  Created by Md Asif Huda on 5/7/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import Foundation

// Implementing Delegate pattern
protocol updateModel {
    func didDownloadItem(arr: [AnyObject])
}

class ParseJson {
    
      var delegate:updateModel?
    
    func searchMovies(searchBarText:String?){
        guard let keyWord = searchBarText, keyWord != "" else {
            return
        }
        let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
        
        let apiKey = "635cdfbf239eb6f85297d3777fbcda86"
        let keyWordFormated = keyWord.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(keyWordFormated)&page=1&include_adult=false"
        guard let nsUrl = NSURL(string: urlString) else {
            return
        }
        var request = NSMutableURLRequest(url: nsUrl as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0) as URLRequest
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        
        // used complition to handle the request
        downloadMovieInfoBy(request)
        
    }
    
    private func downloadMovieInfoBy(_ request: URLRequest){
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let downloadContent = data, error == nil else {
                print("get error when sending URL request: SearchDisplayControler.swift: ", error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: downloadContent, options: .mutableContainers) as! [String:AnyObject]
                
                let movieResults = json["results"] as? [[String:AnyObject]] ?? [["Result":"get no result." as AnyObject]]
                var model = [Movie]()
                for getMovie in movieResults {
                    let newMovie = Movie(dictionary: getMovie)
                    model.append(newMovie)
                }
                
                self.delegate?.didDownloadItem(arr: model)

                
            }catch{
                print(error.localizedDescription)
                
            }
            
        })
        dataTask.resume()
        
    }
}
