//
//  MoviesDetailViewController.swift
//  zee5
//
//  Created by Pavan on 7/21/18.
//  Copyright © 2018 Saven Developer. All rights reserved.
//

import UIKit

class MoviesDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableview_Detail: UITableView!
    @IBOutlet weak var view_Poster: UIView!
    @IBOutlet weak var label_MovieName: UILabel!
    @IBOutlet weak var label_Popularity: UILabel!
    @IBOutlet weak var label_Duration: UILabel!
    @IBOutlet weak var imageview_Poster: UIImageView!
    var isShowFull : Bool = false
    var dict_Response :Dictionary<String,AnyObject>!
    var ary_Geners = [String]()
    var ary_Languages = [String]()
    var movie_Id : Int!
    
    @IBOutlet weak var height_viewPoster: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceCallforMovieDetail()
        height_viewPoster.constant = UIScreen.main.bounds.size.height/2.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func fillUI() {
        
        tableview_Detail.estimatedRowHeight = 120
        tableview_Detail.rowHeight = UITableViewAutomaticDimension
        
            if dict_Response != nil && dict_Response["title"] is String {

            label_MovieName.text = (dict_Response["title"]  as! String)
        }
            if dict_Response != nil && dict_Response["popularity"] is Double {
                
                

            label_Popularity.text = String(format: "Popularity: %.2f",(dict_Response["popularity"] as! Double))
            
        }
            if dict_Response != nil && dict_Response["runtime"] is Int {

            label_Duration.text = String(format: "Duration: %d Mins",dict_Response["runtime"] as! Int)

        }

            DispatchQueue.global(qos: .background).async {
            
                if self.dict_Response != nil && self.dict_Response["poster_path"] is String {


                    let str_path = self.dict_Response["poster_path"] as! String
            
            
            let str_url = String(format: "%@%@", Constants.Constants.APP_IMAGE_BASEURL,str_path)
            
            
            let url = URL(string: str_url)
            
            if let data = try? Data(contentsOf: url!)
            {
                let image: UIImage = UIImage(data: data)!
                
                            DispatchQueue.main.async {
                self.imageview_Poster.image = image
                        }
            }
            
        
            }
                else{
                    DispatchQueue.main.async {
                        self.imageview_Poster.image = UIImage(named: "img")
                    }

                    
                }
        }
        
    }

    //MARK: - Tableview DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewcell")
        
        if indexPath.row == 0 {
            guard let overviewcell = tableView.dequeueReusableCell(withIdentifier: "overviewcell", for: indexPath) as? MoviedetailOverviewTableViewCell else {
                fatalError()
            }
            if dict_Response != nil && dict_Response["overview"] is String {

            if let str_overview =  dict_Response["overview"]{
                overviewcell.label_Overview.text = (str_overview as! String)

            }

            }
            overviewcell.button_Showfull.addTarget(self, action: #selector(isShowFullClicked), for: .touchUpInside)
            if isShowFull{
                overviewcell.button_Showfull.setTitle("Show Less", for: .normal)
            }
            else{
                overviewcell.button_Showfull.setTitle("Show Full..", for: .normal)
            }
            return overviewcell
        }
        
        else{
            
            guard let detailcell = tableView.dequeueReusableCell(withIdentifier: "moviedetailcell", for: indexPath) as? MovieDetailTableViewCell else {
                fatalError()
            }
            
            switch indexPath.row{
                
                
            case 1 :
                detailcell.label_Title.text = "Language"
                let joined = ary_Languages.joined(separator: ", ")

                    detailcell.label_Value.text = joined
                
                break
                
            case 2 :
                detailcell.label_Title.text = "Generes"
                let joined = ary_Geners.joined(separator: ", ")

                detailcell.label_Value.text = joined
                break
                
            case  3 :
                
                detailcell.label_Title.text = "Release Date"
                if dict_Response != nil && dict_Response["release_date"] is String {

                if let str_overview =  dict_Response["release_date"]{
                    detailcell.label_Value.text = (str_overview as! String)
                    
                }
                }
                break
                
                
            default:
                break
            }
            
            
            return detailcell
            
        }
        
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            if isShowFull {
            return UITableViewAutomaticDimension
                
            }
            else{
                
                return 100
            }
            
        }
        else{
            
            return UITableViewAutomaticDimension

        }
        
    }
    
    // MARK:  - Show Full / Show Less Action
    
    @objc func isShowFullClicked(){
        
        if isShowFull  {
            isShowFull = false
            

        }
        else{
            
            isShowFull = true
        }
        
        DispatchQueue.main.async {
            self.tableview_Detail.reloadData()
        }
        
        
    }
    //MARK: -- API Call for Movie Detail
    
    func serviceCallforMovieDetail() {
        // Set up the URL request
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        let str_Urldetail = String(format: "https://api.themoviedb.org/3/movie/%d?api_key=7a312711d0d45c9da658b9206f3851dd", movie_Id)
        
        guard let urlforDetail = URL(string: str_Urldetail) else {
            return
        }
        let urlRequest = URLRequest(url: urlforDetail)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                UIViewController.removeSpinner(spinner: sv)
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("The Response is == ",todo)
                UIViewController.removeSpinner(spinner: sv)
                self.dict_Response = todo as [String : AnyObject]
                
                let genersArray = self.dict_Response["genres"]
                let languagesarray = self.dict_Response["spoken_languages"]

                for dict_gen in genersArray as! [AnyObject]{
                    self.ary_Geners.append((dict_gen["name"]) as! String)
                }
                for dict_gen in languagesarray as! [AnyObject]{
                    self.ary_Languages.append((dict_gen["name"]) as! String)
                }
                
                DispatchQueue.main.async {
                    self.fillUI()
                    self.tableview_Detail.reloadData()
                }
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
