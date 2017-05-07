//
//  DetailViewController.swift
//  Search Movie DB
//
//  Created by Md Asif Huda on 5/7/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var myDetailTableView: UITableView!

    
    var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myDetailTableView.estimatedRowHeight = 80
        self.myDetailTableView.rowHeight = UITableViewAutomaticDimension
        
        self.myDetailTableView.setNeedsLayout()
        self.myDetailTableView.layoutIfNeeded()
        self.myDetailTableView.tableFooterView = UIView()

    }

}

extension DetailViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath as IndexPath) as! DetailViewCell
        
        cell.movieTitle.text = movie?.title
        cell.movieOverView.text = movie?.overview
        
        let imgBasicUrl = "http://image.tmdb.org/t/p/w342/"
        let imgUrl = imgBasicUrl + (movie?.poster_path ?? "/BbA9z4kFuIXmljZTHG3FjCWjQk.jpg")
        cell.movieImage.loadImageUsingCacheWith(urlString: imgUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
  

}

