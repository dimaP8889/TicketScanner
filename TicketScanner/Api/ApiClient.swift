//
//  ApiClient.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation
import Combine

struct APIClient {
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                ResponseHandler.handle(data: result.data, response: result.response)
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}
