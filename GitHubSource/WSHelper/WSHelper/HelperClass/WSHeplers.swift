//
//  WSHeplers.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/6/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import Foundation

/*
 {
 avatar = "https://s3.amazonaws.com/uifaces/faces/twitter/marcoramires/128.jpg";
 "first_name" = Eve;
 id = 4;
 "last_name" = Holt;
 }
 */
//
//struct AvatarDetails: Decodable{
//    
//    let totalPages: Int
//    let pageNo: Int
//    let perPage: Int
//    let total: Int
//}

enum requestType {
    case user, userDetails, pages, country,cars
}

class WSHelpers: NSObject{

    var AvatarDets = [AvatarDetails]()
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(url: myUrl! as URL);
        request.httpMethod = "POST";
        //let param:[String: String] = ["username"  : "+919686765861","password" : "costBo5$"]        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
    
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
            print("******* response = \(String(describing: response))")
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                print(json ?? "")
                
            }catch
            {
                print(error)
            }
        }
        task.resume()
    }
    
    
    /*
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey as Data)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    // MARK: -- Multi Form Request
    func requestMultiForm(){
        
        let urlLink = URL(string:"https://web_app@stagej.costbo.com:8443/costbouaa/oauth/token")!
        
        var request  = URLRequest(url: urlLink)
        request.httpMethod = "POST"
        
        let param = [
            "name":"grant_type",
            "username"    : "919686765861",
            "userId"    : "costBo5$"
        ]
        
        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let username = "919686765861"
        let password = "costBo5$"
        
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        print("base64LoginData \(base64LoginData)")
        
        let tokenID = "Basic d2ViX2FwcDo=\r\n Credentials: web_app"
        request.setValue(tokenID, forHTTPHeaderField: "Authorization")
        
        //        let imageData = UIImageJPEGRepresentation((UIImage(named: "submit.png"))!, 1)
        //        if(imageData==nil)  { return; }
        //        let yourImage: UIImage = (UIImage(named: "submit.png"))!
        //        let imageData: NSData = UIImagePNGRepresentation(yourImage)! as NSData
        
        let boudaryId = "777718375707781470381359\r\n"
        let boundary = "Boundary-\(boudaryId)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = ViewController.createBody(parameters: param,boundary: boundary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
            print("******* response = \(String(describing: response))")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                print(json ?? "")
                
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    
    class func createBody(parameters: [String: String],
                          boundary: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        //        body.appendString(boundaryPrefix)
        //        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        //        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        //        body.append(data)
        //        body.appendString("\r\n")
        //        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
        
     
     */
    // MARK: --- GET Method
   class func requestGetMethod() {
        let url = URL(string:"https://reqres.in/api/users?page=2")!
        
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // execute the datatask and validate the result
        let postTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: [])) {
                print("Response data userObject  == \(userObject)")
                print("-**_*_*_*_*_*_*_*_*_*_*_*_*")
                // you've got the jsonObject
                let responseStatus = response as! HTTPURLResponse
                if responseStatus.statusCode == 200{
                    let responseResult = try? JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as? [String: AnyObject]
                    
                    if let dataArray = responseResult as? [String: Any]
                    {
                        print("dataArray \(String(describing: dataArray["data"]))")
                        print("-**_*_*_*_*_*_*_*_*_*_*_*_*")
                        if let pageNo = dataArray["page"]as? Int{
                            print("Get page =\(String(describing: pageNo))")
                        }
                        if let pagePer = dataArray["per_page"]as? Int{
                            print("Get pagePer =\(String(describing: pagePer))")
                        }
                        if let totals = dataArray["total"]as? Int{
                            print("Get totals =\(String(describing: totals))")
                        }
                        if let totalPages = dataArray["total_pages"]as? Int{
                            print("Get totalPages =\(String(describing: totalPages))")
                        }
                        print("-**_*_*_*_*_*_*_*_*_*_*_*_*")
                        print("------dataArray Items === \(String(describing: dataArray["data"] as? NSArray))")
                        
                        print("-**_*_*_*_*_*_*_*_*_*_*_*_*")
                        
                        let dataArr = responseResult!!["data"] as? [String:Any]
                        print(dataArr as Any)
                        
//                        for  (key,value) in dataArr
//                        {
//                            print("value \(value) ")
////                            for testvalue in testvalue as [String: Any]{
////
////                                print("testvalue \(testvalue) ")
////                                if let avatar = testvalue["avatar"]as? NSDictionary{
////                                    print("Get avatar =\(String(describing: avatar))")
////                                }
////                            }
//                        }
                    }
                    
//                    //self.AvatarDets.
//                    if let dataArray = responseResult as? [String: Any]{
//
//                        print("------dataArray === \(String(describing: dataArray["data"] as? NSArray))")
//
//                        for testvalue in dataArray{
//                            print("testvalue \(testvalue) ")
//                        }
//
////                        guard (try? JSONDecoder().decode(DataModel.AvatarItems.self, from:data!)) != nil else {
////                            print("Check Avatar Failed read")
////                            return
////                        }
////                        print("first name \(avatordets.firstName)")
////                        print("last name \(avatordets.lastName)")
//                    }
                }
            }
        }
        postTask.resume()
    }
    
    func requestGetMethod(){
        
        let url = "https://restcountries.eu/rest/v2/all"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self as? URLSessionDelegate , delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){
            (data, response, error) in
            if (error != nil){
                print("Error")
            }else{
                do{
                    let fetchedData = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers) as! NSArray
                    print(fetchedData as Any)
                    
                }catch{
                    print("catch error")
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: --- POST Method
    func requestPOSTMethod()-> Void{
        
        let urlLink = URL(string:"https://reqres.in/api/users?")!
        let request = NSMutableURLRequest(url: urlLink)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let postData = "name=morpheus&job=leader"
        let httpData = try? JSONSerialization.data(withJSONObject: postData, options: [])
        request.httpBody = httpData
        let taskRequest = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            guard let _: Data = data, let _ :URLResponse = response, error == nil else{
                print("---  Error Occured in request")
                return
            }
            
            let urlResponse = response as! HTTPURLResponse
            if urlResponse.statusCode == 200{
                print("Response JSON DATA = \(response.debugDescription)")
                let responseResult = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("responseResult \(String(describing: responseResult))")
                if let dataArray = responseResult as? [String:Any]{
                    print("dataArray \(dataArray)")
                    if let dataList = dataArray["data"] as? [Any]{
                        print("dataList \(dataList)")
                        for value in dataList{
                            print("Data List Item \(value)")
                        }
                    }
                }
            }
        }
        taskRequest.resume()
    }
    
    
    func dataRequest() {
        
        // https://jsonplaceholder.typicode.com
        // http://services.groupkt.com/country/search?
        //
        let urlToRequest = "http://services.groupkt.com/country/search?"
        let url4 = URL(string: urlToRequest)!
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "text=un"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session4.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            print("response \(String(describing: response))")
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(String(describing: dataString))") //JSONSerialization
        }
        task.resume()
    }
    
    func postMethodWithData(){
        
        let urlString = URL(string: "http://jsonplaceholder.typicode.com/users/1")
        let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            if let httpResponseCode = response as? HTTPURLResponse{
                if httpResponseCode.statusCode == 200{
                    print("error \(httpResponseCode.statusCode)")
                    let responseResult = try? JSONSerialization.jsonObject(with: data!, options: [])
                    print("response result \(String(describing: responseResult))")
                    if responseResult != nil{
                        
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
