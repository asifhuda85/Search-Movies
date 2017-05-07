//
//  ViewController.swift
//  Search Movie DB
//
//  Created by Md Asif Huda on 5/7/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit

class ViewController: UIViewController,updateModel {

    @IBOutlet weak var myTableView: UITableView!
    
    var models = [Movie?]()
    var model: Movie?

    @IBOutlet weak var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.tableFooterView = UIView()

    }
    
    @IBAction func searchMovieButtonClicked(_ sender: UIBarButtonItem) {
        let api = ParseJson()
        
        api.delegate = self
        guard let keyWord = searchTextField.text, keyWord != "" else {
            showAlertWith(title: "Try Again", message: "Please type a movie name")
            return
        }

        api.searchMovies(searchBarText: searchTextField.text)
        searchTextField.text = ""
    }
    
    //Implemented the Protocl function
    func didDownloadItem(arr: [AnyObject]) {
        self.models = arr as! [Movie]
        DispatchQueue.main.async {
            self.myTableView.reloadData()
            self.myTableView.contentOffset = .zero
        }
    }
    
    func showAlertWith(title:String, message:String){
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertCtrl.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alertCtrl.dismiss(animated: true, completion: nil)
        }))
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath as IndexPath) as! MyTableViewCell
        let model = models[indexPath.row]
        cell.movieName.text = model?.title
        cell.releaseDate.text = model?.release_date
        let imgBasicUrl = "http://image.tmdb.org/t/p/w342/"
        let imgUrl = imgBasicUrl + (model?.poster_path ?? "/BbA9z4kFuIXmljZTHG3FjCWjQk.jpg")
        cell.movieImage.image = UIImage(named: "dummy")
        cell.movieImage.loadImageUsingCacheWith(urlString: imgUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = models[indexPath.item]
        model = selectedMovie
        performSegue(withIdentifier: "segue", sender: self)

    }
    // Passing movie object to detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue") {
            let viewController = segue.destination as? DetailViewController
            viewController?.movie = model
        }
    }
}
