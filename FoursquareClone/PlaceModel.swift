//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by emn on 8.05.2022.
//

import Foundation
import UIKit


class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var palceLongitude = ""
    
    private init() {}
}
