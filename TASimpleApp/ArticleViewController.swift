//
//  ArticleViewController.swift
//  TASimpleApp
//
//  Created by Marutharaj Kuppusamy on 10/20/18.
//  Copyright © 2018 ta. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var articleTableView: UITableView!

    var articles =  [Article]()
    var article: Article?
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showActivityIndicator()
        ArticleService().sendRequest(period: 7, completionHandler: { (articles) in
            // here is your article object
            self.articles = articles
            DispatchQueue.main.async {
                self.activityIndicator.removeFromSuperview()
                self.articleTableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityIndicator() {
        // Add it to the view where you want it to appear
        self.view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        // Start the loading animation
        activityIndicator.startAnimating()
    }
    
    // MARK: - Navigation Bar Button Item Action
    
    @IBAction func showSearchOption(sender: AnyObject) {
        let alert = UIAlertController(title: "Article Period", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "1", style: .default, handler: { (_)in
            self.showActivityIndicator()
            ArticleService().sendRequest(period: 1, completionHandler: { (articles) in
                // here is your article object
                self.articles = articles
                DispatchQueue.main.async {
                    self.activityIndicator.removeFromSuperview()
                    self.articleTableView.reloadData()
                }
            })
        }))
        
        alert.addAction(UIAlertAction(title: "7", style: .default, handler: { (_) in
            self.showActivityIndicator()
            ArticleService().sendRequest(period: 7, completionHandler: { (articles) in
                // here is your article object
                self.articles = articles
                DispatchQueue.main.async {
                    self.activityIndicator.removeFromSuperview()
                    self.articleTableView.reloadData()
                }
            })
        }))
        
        alert.addAction(UIAlertAction(title: "30", style: .default, handler: { (_) in
            self.showActivityIndicator()
            ArticleService().sendRequest(period: 30, completionHandler: { (articles) in
                // here is your article object
                self.articles = articles
                DispatchQueue.main.async {
                    self.activityIndicator.removeFromSuperview()
                    self.articleTableView.reloadData()
                }
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCellIdPeriphery", for: indexPath) as? ArticleTableViewCell
        
        let article = self.articles[indexPath.row]
        
        cell?.articleByLabel.text = article.byline
        cell?.articlePublishedDateLabel.text = article.publishedDate
        //cell.indexPath = indexPath.row
        
        let imageUrl = TAUtility().getArticleThumbnailUrl(article: article)
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData: NSData = NSData(contentsOf: imageUrl)!
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell?.articleImageView.image = image
                cell?.articleImageView.contentMode = UIViewContentMode.scaleAspectFit
            }
        }
        
        if let titleCount = article.title?.count {
            if titleCount > 40 {
                guard let index = article.title?.index((article.title?.startIndex)!, offsetBy: 30) else {
                    return cell!
                }
                cell?.articleTitleLabel.text = article.title![..<index] + "..."
            } else {
                cell?.articleTitleLabel.text = article.title
            }
        } else {
          print("unexpected title count")
        }
        
        return cell!
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "articleDetailSegueIdentifier" {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as? ArticleDetailViewController
            // your new view controller should have property that will store passed value
            //let cell : ArticleTableViewCell = sender as! ArticleTableViewCell
            let indexPath: IndexPath = self.articleTableView.indexPathForSelectedRow!
            viewController?.article = self.articles[indexPath.row]
        }
    }
}
