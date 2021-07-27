//
//  ApiClient.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation
import Combine

struct APIClient {
    
    func run<T: Decodable, F: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T, F>, Never> { // 2
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T,F> in
                ResponseHandler.handle(data: result.data, response: result.response)
            }
            .replaceError(with: .system("Publisher Error"))
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}
