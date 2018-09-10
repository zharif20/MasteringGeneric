//
//  ViewController.swift
//  MasteringGeneric
//
//  Created by Local on 10/09/2018.
//  Copyright © 2018 Local. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        fetchHomeFeed { (homeFeed) in
//            homeFeed.videos.forEach({print($0.name)})
//        }
        
//        fetchCourseDetail { (courseDetails) in
//            courseDetails.forEach({print($0.name, $0.duration)})
//        }
        
//        fetchGenericData { (courseDetails: [CourseDetail]) in
//            courseDetails.forEach({print($0.name, $0.duration)})
//        }
        
        fetchGenericData(urlString: "http://api.letsbuildthatapp.com/youtube/home_feed") { (homeFeed: HomeFeed) in
            homeFeed.videos.forEach({print($0.name)})
        }
        
        fetchGenericData(urlString: "http://api.letsbuildthatapp.com/youtube/course_detail?id=1") { (courseDetails: [CourseDetail]) in
            courseDetails.forEach({print($0.name, $0.duration)})
        }
        
    }

//    fileprivate func fetchHomeFeed(completion: @escaping (HomeFeed) -> ())
//    {
//        let urlString = "http://api.letsbuildthatapp.com/youtube/home_feed"
//
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//
//            do {
//                let homeFeed = try JSONDecoder().decode(HomeFeed.self, from: data)
//                completion(homeFeed)
//            } catch let jsonErr {
//                print("Failed to decode json:", jsonErr)
//            }
//        }.resume()
//    }
//
//    fileprivate func fetchCourseDetail(completion: @escaping ([CourseDetail]) -> ()){
//        guard let url = URL(string: "http://api.letsbuildthatapp.com/youtube/course_detail?id=1") else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else { return }
//
//            do {
//                let courseDetails = try JSONDecoder().decode([CourseDetail].self, from: data)
//                completion(courseDetails)
//            } catch let jsonErr {
//                print("Failed to decode json:",jsonErr)
//            }
//        }.resume()
//    }
    
    
    fileprivate func fetchGenericData <T: Decodable>(urlString:String, completion: @escaping (T) -> ()){
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error:", err)
            }
            
            guard let data = data else { return }
            
            do {
                let genericData = try JSONDecoder().decode(T.self, from: data)
                completion(genericData)
            } catch let jsonErr {
                print("Failed to decode json:",jsonErr)
            }
        }.resume()
    }

}

struct CourseDetail: Decodable {
    let name: String
    let duration: String
}


struct HomeFeed: Decodable {
    let videos: [Video]
}

struct Video: Decodable {
    let id: Int
    let name: String
}
