//
//  ApiManager.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation
import Combine

final class Networking {
    
    private static let globalURL = "https://ticket-checkin.development.2204ticketing.entireframework.com"
    
    static let main = API<MainApi>(base: globalURL)
}


class API<RQ: Requestable> : NSObject, URLSessionDelegate {
    
    private let base : URL
    private var apiClient = APIClient()
    
    init?(base: String) {
        guard let _base = URL(string: base) else {
            return nil
        }
        
        self.base = _base
        super.init()
    }
}

extension API where RQ: Requestable {
    
    func sync<T : Decodable, F: Decodable>(_ rqParams : RQ) -> AnyPublisher<Response<T,F>, Never> {
        
        let url = createUrl(rqParams)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = rqParams.parameters().compactMap {
            URLQueryItem(name: $0, value: $1)
        }
        let query = components?.percentEncodedQuery
        components?.percentEncodedQuery = query?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let _url = components?.url else {
            fatalError("Recheck params")
        }
        
        var request = URLRequest(url: _url)
        if rqParams.authorizationRequired() {
            request.allHTTPHeaderFields = authorizationHeaders()
        }
        
        let formData = getData(params: rqParams.formData())
        
        request.httpBody = formData
        request.allHTTPHeaderFields?.merge(rqParams.headers()) { (_, new) in new }
        request.httpMethod = rqParams.httpMethod()
        return apiClient.run(request)
    }
}

private extension API {
    
    func getData(params: [String : Any]) -> Data? {

        guard !params.isEmpty else { return nil }
        return try! JSONSerialization.data(
            withJSONObject: params, options: []
        )
    }
    
    func authorizationHeaders() -> [String : String] {
        
        if let auth = Keychain.shared.accessToken {
            return ["Authorization" : "Bearer \(auth)"]
        }
        return [:]
    }
    
    func createUrl(_ rqParams : RQ) -> URL {
        
        let endPoint = rqParams.endPointRoute()
        let urlString = endPoint
        
        let url = base.appendingPathComponent(urlString)
        return url
    }
}
