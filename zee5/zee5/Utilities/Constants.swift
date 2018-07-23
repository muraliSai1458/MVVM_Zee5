//
//  Constants.swift
//  zee5
//
//  Created by Pavan on 7/21/18.
//  Copyright © 2018 Saven Developer. All rights reserved.
//

import UIKit

class Constants: NSObject {

    struct Constants {
        //App Constants
        static let COLOR_GRAY = UIColor.init(red: 113.0/256.0, green: 117.0/256.0, blue: 113.0/256.0, alpha: 1.0)
        
        static let APP_MOVIESLIST = "https://api.themoviedb.org/3/movie/popular?api_key=7a312711d0d45c9da658b9206f3851dd&page=10"
        
        static let APP_MOVIESDETAILS = "https://api.themoviedb.org/3/movie/8355?api_key=7a312711d0d45c9da658b9206f3851dd"
        
        static let APP_IMAGE_BASEURL = "https://image.tmdb.org/t/p/w200/"
        
        
    }
}

