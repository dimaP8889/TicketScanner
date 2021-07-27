//
//  ResponseHandler.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation

import Foundation

final class ResponseHandler {
    
    static func handle<S: Decodable, F: Decodable>(data : Data?, response : URLResponse?) -> Response<S, F> {
        let apiResponse : ApiResponse<S, F> = parseResponse(data: data, response: response)
        return simplifyResponse(response: apiResponse)
    }
}

// MARK: - Private
private extension ResponseHandler {

    static func parseResponse<S: Decodable, F: Decodable>(data : Data?, response : URLResponse?) -> ApiResponse<S, F>  {

        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            return .failure(.system(.missingHTTPCode))
        }
        
        guard var _data = data else {
            return .failure(.system(.missingData))
        }
        
        print("Response: ", String(data: _data, encoding: .utf8))
        guard 200..<300 ~= code else {
            do {
                let responseObject = try JSONDecoder().decode(F.self, from: _data)
                return .failure(.backend(responseObject))
            } catch {
                #warning("Need to check if auth vode expired")
                return .failure(.system(.badHTTPCode(code)))
            }
        }
            
        do {
            if _data.isEmpty {
                _data = "{}".data(using: .utf8)!
            }
            let responseObject = try JSONDecoder().decode(S.self, from: _data)
            return .success(responseObject)
        } catch let decodeError {
            return .failure(.system(.jsonMappingFailed(decodeError)))
        }
    }
    
    static func simplifyResponse<S: Decodable, F: Decodable>(response: ApiResponse<S, F> ) -> Response<S, F> {
        switch response {
        case let .success(response):
            return .success(response)
        case let .failure(error):
            return findError(from: error)
        }
    }
    
    static func findError<S: Decodable, F: Decodable>(from response: APIError<F>) -> Response<S, F> {
        switch response {
        case let .backend(error):
            return .backend(error)
        case let .system(error):
            return .system(error.message)
        }
    }
}

enum ApiResponse<S,F> {
    
    case success(S)
    case failure(APIError<F>)
}

enum Response<S,F> {
    
    case success(S)
    case backend(F)
    case system(String)
}

enum APIError<T> {
    
    case system(SystemError)
    case backend(T)
//    case refreshTokenInvalid
//    case accessTokenInvalid
//    case expiredToken
    
    enum SystemError : Error {
        
        case onRequestCreation
        case onRequestExecute(Error)
        case missingHTTPCode
        case badHTTPCode(Int)
        case missingData
        case jsonMappingFailed(Error)
        
        var message : String {
            switch self {
            case let .badHTTPCode(code):
                return "bad code \(code)"
            case let .jsonMappingFailed(error):
                return error.localizedDescription
            default:
                return "System Error"
            }
        }
    }
}

struct ErrorResponse : Decodable {
    
    let response : String
}
