//
//  NetworkClient.swift
//  Detector
//
//  Created by Macbook on 26/07/2022.
//

import UIKit

typealias ApiResponseHandler = (Data?, URLResponse?, Error?) -> Void

enum HttpMethod: String
{
    case get = "GET"
    case post = "POST"
}

//MARK:- All Interaction with network client is done through this protocol
protocol NetworkClientInteraction
{
//    func makeRequest(url: String, httpMethod: HttpMethod, body: [String: Any]?, completion: @escaping ApiResponseHandler)
//    func getApiRequest(url: String, completion: @escaping ApiResponseHandler)
    func postApiRequest(url: URL, body: [String: Any], completion: @escaping ApiResponseHandler)
}

//MARK:- Network Client
class NetworkClient
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    static let shared: NetworkClientInteraction = NetworkClient()
    private init() {}
    
    private let sharedSession = URLSession.shared
    
    //------------------------------------------------------------
    //MARK:- Functionality
    //------------------------------------------------------------
    
    //try taking body of codable type protocol here
    private func getData(url: URL, httpMethod: HttpMethod, body: [String: Any]? = nil, completion: @escaping ApiResponseHandler)
    {
//        guard let url = URL(string: url)
//        else
//        {
//            return
//        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        if let body = body
        { urlRequest.httpBody = getDataForHttpbody(body: body) }
        
        let task = sharedSession.dataTask(with: urlRequest)
        { data, response, error in
            
            completion(data, response, error)
        }
        
        task.resume()
    }
    
    private func getDataForHttpbody(body: [String: Any]) -> Data?
    {
        let data = try? JSONSerialization.data(withJSONObject: body)
        print(try? JSONSerialization.jsonObject(with: data ?? Data()))
        return data
    }
}

//MARK:- Network Client Public Interaction
extension NetworkClient: NetworkClientInteraction
{
//    func makeRequest(url: String, httpMethod: HttpMethod, body: [String : Any]? = nil, completion: @escaping ApiResponseHandler)
//    { getData(url: url, httpMethod: httpMethod, body: body, completion: completion) }
//
//    func getApiRequest(url: String, completion: @escaping ApiResponseHandler)
//    { getData(url: url, httpMethod: .get, completion: completion) }
    
    func postApiRequest(url: URL, body: [String: Any], completion: @escaping ApiResponseHandler)
    { getData(url: url, httpMethod: .post, body: body, completion: completion) }
}
