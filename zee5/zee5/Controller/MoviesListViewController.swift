//
//  MoviesListViewController.swift
//  zee5
//
//  Created by Saven Developer on 7/20/18.
//  Copyright © 2018 Saven Developer. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var ary_MoviesList = [MoviesListModelClass]()
    var ary_records : [Int] = Array()
    var limit = 20
    var totalEntries : Int?
    var movie_ID : Int?
    
    
    
    @IBOutlet weak var collectionview_MoviesList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSizeWidth = UIScreen.main.bounds.width/4 - 3
        let itemSizeHeight = (UIScreen.main.bounds.height - 90) / 5 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        print("Commit")
        collectionview_MoviesList.collectionViewLayout = layout
        
        // Service Call for Getting Movies List
        ServiceCallforMoviesList(pageNo: 1)
        

    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: --API Call for Getting Movies List
    
    func ServiceCallforMoviesList(pageNo : Int) {
        // Set up the URL request
        
        
        let str_Url = String(format: "https://api.themoviedb.org/3/movie/popular?api_key=7a312711d0d45c9da658b9206f3851dd&page=%d", pageNo)
        
        guard let moviesListUrl = URL(string: str_Url) else {
            return
        }
        let urlRequest = URLRequest(url: moviesListUrl)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
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
                guard let dictionary_Response = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
//                print("response is %@",dictionary_Response)
                
                if let totalpages = dictionary_Response["total_results"]{
                    self.totalEntries = (totalpages as! Int)
                }
                let ary_MoviesListRecords = dictionary_Response["results"] as! Array<Dictionary<String,AnyObject>>
                for dict_MoviesListRecord in ary_MoviesListRecords {
                    var obj_MoviesListListRecord:MoviesListModelClass!
                    obj_MoviesListListRecord = MoviesListModelClass.getMoviesListObjectForDictionary(dict_MoviesListModel: dict_MoviesListRecord)
                    self.ary_MoviesList.append(obj_MoviesListListRecord)
                }

                DispatchQueue.main.async {
                    self.collectionview_MoviesList.layoutIfNeeded()
                    self.collectionview_MoviesList.reloadData()
                    
                }
                
              
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }

    
    //MARK:- Collectionview Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ary_MoviesList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movies", for: indexPath) as? MoviesListCollectionViewCell else {
            fatalError("")
        }
        
        let obj_Movie = ary_MoviesList[indexPath.row]
        
        
        DispatchQueue.global(qos: .background).async {

            let urlimage = URL(string:obj_Movie.str_displayPoster_Path!)

            if let imageUrl = urlimage{
      
        if let data = try? Data(contentsOf: imageUrl)
        {
            let image: UIImage = UIImage(data: data)!
            
            DispatchQueue.main.async {
                cell.image_Movie.image = image
            }
        }
            }
            else{
                DispatchQueue.main.async {
                cell.image_Movie.image = UIImage(named: "img")
                }
            }
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let obj_MoviesList = ary_MoviesList[indexPath.row]
        movie_ID = obj_MoviesList.int_id
        performSegue(withIdentifier: "MoviesDetail", sender: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == ary_MoviesList.count-1 {
            if ary_MoviesList.count < totalEntries!{
                let index = ary_MoviesList.count
                limit = index+20
                print("%@ is the Page Number",limit/20)
                ServiceCallforMoviesList(pageNo: limit/20)
            }
        }
        
    }
    
    
    

    
    
    // MARK: - Navigation

  //  In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MoviesDetail" {
            let detailVC = segue.destination as! MoviesDetailViewController
            detailVC.movie_Id = movie_ID

        }
        
        
    }

}
