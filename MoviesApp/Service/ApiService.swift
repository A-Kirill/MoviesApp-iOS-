//
//  ApiService.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 09.02.2022.
//

import Foundation
import Combine

fileprivate struct APIConstants {
    
//    Create your own key on https://kinopoiskapiunofficial.tech
//    static let apiKey: String = "yourKey"
    
    static var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Api-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Api-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Api-Info.plist'.")
        }
        return value
      }
    }
}


struct API {
        
    // API Errors:
    enum Error: LocalizedError {
        case addressUnreachable(URL)
        case decodingFailed(String)
        case invalidResponse
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "The server responded with garbage."
            case .decodingFailed(let name): return "error decode \(name)"
            case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
            }
        }
    }
    
    
    // API endpoints:
    enum EndPoint {
        static let baseURL = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/")!
        
        case premiers
        case movieByKeyword(String)
        case movieDetail(Int)
        case videos(Int)
        case images(Int)
        
        var url: URLRequest {
            switch self {
            case .premiers:
                var url = URLComponents(url: EndPoint.baseURL.appendingPathComponent("premieres"),
                                        resolvingAgainstBaseURL: true)!
                let queryItems = [URLQueryItem(name: "year", value: "2022"),
                                  URLQueryItem(name: "month", value: currentMonth)]
                url.queryItems = queryItems
                var request = URLRequest(url: url.url!)
                request.addValue(APIConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
                return request
                
            case .movieByKeyword(let name):
                var url = URLComponents(url: EndPoint.baseURL,
                                        resolvingAgainstBaseURL: true)!
                let queryItems = [URLQueryItem(name: "keyword", value: name)]
                url.queryItems = queryItems
                var request = URLRequest(url: url.url!)
                request.addValue(APIConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
                return request
                
            case .movieDetail(let id):
                var request = URLRequest(url: EndPoint.baseURL.appendingPathComponent("\(id)"))
                request.addValue(APIConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
                return request
                
            case .videos(let id):
                var request = URLRequest(url: EndPoint.baseURL.appendingPathComponent("\(id)/videos"))
                request.addValue(APIConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
                return request
                
            case .images(let id):
                var request = URLRequest(url: EndPoint.baseURL.appendingPathComponent("\(id)/images"))
                request.addValue(APIConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
                return request
            }
        }
        
        private var currentMonth: String {
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            dateFormatter.locale = Locale(identifier: "en")
            return dateFormatter.string(from: now).uppercased()
        }
    }
    
    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
    
//    MARK: - public methods
    
    func movieDetailsBy(id: Int) -> AnyPublisher<MovieDetails, Error> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.movieDetail(id).url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: MovieDetails.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.movieDetail(id).url.url!)
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getVideosFor(_ id: Int) -> AnyPublisher<VideoResponse, Error> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.videos(id).url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: VideoResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.videos(id).url.url!)
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getImagesFor(_ id: Int) -> AnyPublisher<ImageResponse, Error> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.images(id).url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: ImageResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.images(id).url.url!)
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    func premiers() -> AnyPublisher<APIResponse, Error> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.premiers.url)
            .map { $0.data }
            .decode(type: APIResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.premiers.url.url!)
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func searchByKeyword(_ name: String) -> AnyPublisher<APIResponse, Error> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.movieByKeyword(name).url)
            .map{ $0.data }
            .decode(type: APIResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.movieByKeyword(name).url.url!)
                case is Swift.DecodingError:
                    return .decodingFailed(error.localizedDescription)
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
}
