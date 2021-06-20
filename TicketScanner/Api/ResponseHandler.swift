//
//  ResponseHandler.swift
//  TicketScanner (iOS)
//
//  Created by Dmytro Pogrebniak on 20.06.2021.
//

import Foundation

import Foundation

final class ResponseHandler {
    
    static func handle<T: Decodable>(data : Data?, response : URLResponse?) -> Response<T> {
        parseResponsee(data: data, response: response)
    }
}

// MARK: - Private
private extension ResponseHandler {

    static func parseResponsee<T: Decodable>(data : Data?, response : URLResponse?) -> Response<T>  {

        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            return .failure(.system(.missingHTTPCode))
        }
        
        guard var _data = data else {
            return .failure(.system(.missingData))
        }
        
        //print("Response: ", String(data: _data, encoding: .utf8))
        guard 200..<300 ~= code else {
            do {
                let responseObject = try JSONDecoder().decode(ErrorResponse.self, from: _data)
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
            let responseObject = try JSONDecoder().decode(T.self, from: _data)
            return .success(responseObject)
        } catch let decodeError {
            return .failure(.system(.jsonMappingFailed(decodeError)))
        }
    }
}

enum Response<T> {
    
    case success(T)
    case failure(APIError)
}

enum APIError {
    
    case system(SystemError)
    case backend(ErrorResponse)
    case refreshTokenInvalid
    case accessTokenInvalid
    case expiredToken
    
    enum SystemError : Error {
        
        case onRequestCreation
        case onRequestExecute(Error)
        case missingHTTPCode
        case badHTTPCode(Int)
        case missingData
        case jsonMappingFailed(Error)
    }
}

struct ErrorResponse : Decodable {
    
    let response : String
}
