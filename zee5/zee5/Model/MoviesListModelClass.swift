//
//  MoviesListModelClass.swift
//  zee5
//
//  Created by Pavan on 7/21/18.
//  Copyright © 2018 Saven Developer. All rights reserved.
//

import UIKit

class MoviesListModelClass: NSObject {

    var int_vote_count:Int?
    var int_id:Int?
    var bool_video:Bool?
    var int_vote_average:Int?
    var str_title:String?
    var int_popularity:Int?
    var str_poster_path:String?
    var str_original_language:String?
    var str_original_title:String?
    var str_backdrop_path:String?
    var bool_adult:Bool?
    var str_overview:String?
    var genre_ids : Dictionary<String,AnyObject>?
    var str_displayPoster_Path : String?
    
    
    
    class func getMoviesListObjectForDictionary(dict_MoviesListModel:Dictionary<String,AnyObject>) -> MoviesListModelClass {
        
        let object_MoviesListModel = MoviesListModelClass()
        object_MoviesListModel.int_vote_count = dict_MoviesListModel["vote_count"] as? Int
        object_MoviesListModel.int_id = dict_MoviesListModel["id"] as? Int
        object_MoviesListModel.bool_video = dict_MoviesListModel["video"] as? Bool
        object_MoviesListModel.int_vote_average = dict_MoviesListModel["vote_average"] as? Int
        object_MoviesListModel.str_title = dict_MoviesListModel["title"] as? String
        object_MoviesListModel.int_popularity = dict_MoviesListModel["popularity"] as? Int
        object_MoviesListModel.str_poster_path = dict_MoviesListModel["poster_path"] as? String
        object_MoviesListModel.str_original_language = dict_MoviesListModel["original_language"] as? String
        object_MoviesListModel.str_original_title = dict_MoviesListModel["original_title"] as? String
        object_MoviesListModel.str_backdrop_path = dict_MoviesListModel["backdrop_path"] as? String
        object_MoviesListModel.bool_adult = dict_MoviesListModel["adult"] as? Bool
        object_MoviesListModel.str_overview = dict_MoviesListModel["overview"] as? String
        object_MoviesListModel.str_displayPoster_Path = String(format: "%@%@", Constants.Constants.APP_IMAGE_BASEURL,dict_MoviesListModel["poster_path"] as! CVarArg)
        return object_MoviesListModel
    }

}
