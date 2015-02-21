//
//  ViewController.swift
//  RottenTomatoesDemo
//
//  Created by Vinod Sirimalle on 2/17/15.
//  Copyright (c) 2015 vs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var titles = ["Kingsman", "50 Shades of Gray", "Garfield", "Spongebob", "American Sniper", "Jupiter Ascending"]
    
    var movie = [
        "title" : "Seventh Son",
        "cast" : "Jeff Br,idges, Julianne Moore",
        "year" : "2015",
        "synopsis" : "In a long time past...",
        "rating" : "PG-13"
    ]
    
    var movies: [NSDictionary]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 113
        
        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us")!
        
        var request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            self.movies = dictionary["movies"] as [NSDictionary]
            self.tableView.reloadData()
           
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        
        println("Index path: \(indexPath.row)")
        
        var movie = movies[indexPath.row]
        var posters = movie["posters"] as NSDictionary
        var url = posters["thumbnail"]
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String

        return cell
    }
}

