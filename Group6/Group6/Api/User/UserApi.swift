//
//  UserApi.swift
//  Group6
//
//  Created by Alessandro Capodanno on 23/02/22.
//

import Foundation
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class UserApi{
    
    func signup(username:String,email:String,password:String){
        var semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: host+"/signup?username=\(username)&email=\(email)&password=\(password)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    func signin(email:String,password:String)-> User{
        
        var semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: host+"/signin?email=\(email)&password=\(password)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        return User(id: 1,isOperator: true, userName: "Shark73", level: 2, points: 2, profileImage: nil, reportings: [])
        
    }
    func getUserById(id:Int)->User{
        var semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: host+"ged-user-by-id/\(41)")!,timeoutInterval: Double.infinity)
        request.addValue("JSESSIONID=7E7CBEB7D144D94D3C892751F419A2A8", forHTTPHeaderField: "Cookie")
        
        request.httpMethod = "GET"
        
        var id : Int?
        var username : String?
        var email: String?
        var reports = [ReportModel]()
        var badges = [Badge]()
        var enable : Bool?
        var isOperator : Bool?
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            do{
                if  var json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],let  user = json["message"] as? [String: Any]{
                    id = user["id"] as? Int ?? 00
                    username = user["username"] as? String ?? ""
                    email = user["username"] as? String ?? ""
                    reports = [ReportModel]()
                    badges = [Badge]()
                    enable = user["enable"] as? Bool ?? false
                    isOperator = user["operator"] as? Bool ?? false
                }
            }catch{
                print("Error!")
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return User(id: id!,isOperator: isOperator!, userName: username!, level: 2, points: 2, profileImage: nil, reportings: [])
        
    }
    
    func updateIsOperator(){
        var semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: host + "/update-is-operator/41")!,timeoutInterval: Double.infinity)
        request.addValue("JSESSIONID=7E7CBEB7D144D94D3C892751F419A2A8", forHTTPHeaderField: "Cookie")
        
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
}
