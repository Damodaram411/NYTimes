//
//  ViewController.swift
//  NYTimes
//
//  Created by Damu on 15/11/18.
//  Copyright © 2018 Damu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var articalListTableView: UITableView!
    let reuseIdentifier = "ArticalList"
    let api_key = "bb74a93967934fafaf7915b959dc2eb7"
    var artcialListArray : [Result]?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        basicIntilaizations()
        getArticalsfromServer(false)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func basicIntilaizations()
    {
        articalListTableView.register(UINib(nibName: "ArticalTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        articalListTableView.estimatedRowHeight = 120
        articalListTableView.rowHeight = UITableView.automaticDimension
        articalListTableView.addSubview(self.refreshControl)
        articalListTableView.alwaysBounceVertical = true
        updatenavigationBarAppreance()
    }
    func updatenavigationBarAppreance()
    {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 112.0/255.0, green: 228.0/255.0, blue: 195.0/255.0, alpha: 1.0)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getArticalsfromServer(true)
        
    }
    func getArticalsfromServer(_ isrefresh : Bool)
    {

        let urlString = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(api_key)"
        guard let url = URL(string: urlString) else { return }
        if(!isrefresh)
        {
        self.startLoading()
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                self.stopLoading()
                self.refreshControl.endRefreshing()
            }
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.showAlertWithMessage("Unable to load data please try later")
                }
                return
                
            }
            
            self.parseJsonData(data: data)
            }.resume()
    }
    
    func parseJsonData(data : Data)
    {
        //Implement JSON decoding and parsing
        do {
            //Decode retrived data with JSONDecoder and assing type of Article object
            let articlesData = try JSONDecoder().decode(PopularArticals.self, from: data)
            
            //Get back to the main queue
            DispatchQueue.main.async {
                //print(articlesData)
                self.artcialListArray = articlesData.results
                self.articalListTableView.reloadData()
            }
            
        } catch let jsonError {
            print(jsonError)
            DispatchQueue.main.async {
                self.showAlertWithMessage("Unable to load data please try later")
            }

        }
    }
    
    func showAlertWithMessage(_ message : String)
    {
        let alertView = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        
        alertView.addAction(okAction)
        self.present(alertView, animated: true) {
            
        }
    }
    // Mark Button Actions
    
    @IBAction func searchButtonAction(_ sender: Any) {
        
        showAlertWithMessage("Search button pressed")
    }
    @IBAction func menuButtonAction(_ sender: Any) {
        
        showAlertWithMessage("Left menu button pressed")
        
    }
    @IBAction func moreMenuButtonAction(_ sender: Any) {
        showAlertWithMessage("More menu button pressed")
        
    }
}
extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artcialListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArticalTableViewCell
        tableViewCell.selectionStyle = .none
        tableViewCell.accessoryType = .disclosureIndicator
        if let articalData = artcialListArray?[indexPath.row]
        {
        tableViewCell.cellData = articalData
        }
        return tableViewCell

        
    }
    
    
}
extension ViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected")
        
        guard let articalData = artcialListArray?[indexPath.row]  else {
            print("Unable To Load")
            return
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.articalTitle = articalData.title
        detailsViewController.descriptionurl = articalData.url
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

