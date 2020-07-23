//
//  GameStore.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 01/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

class GameStore: GameService {
  
  static let shared = GameStore()
  
  private let baseURL = "https://api.rawg.io/api/games"
  private let urlSession = URLSession.shared
  private let jsonDecoder = Utils.jsonDecoder
  
  func fetchGames(completion: @escaping (Result<GameResponse, GameError>) -> ()) {
    guard let url = URL(string: baseURL) else {
      completion(.failure(.invalidEndpoint))
      return
    }
    
    let queryItems = [
      URLQueryItem(name: "page_size", value: "8")
    ]
    
    self.loadURLAndDecodeData(url: url, params: queryItems, completion: completion)
  }
  
  func fetchGame(id: Int, completion: @escaping (Result<GameDetailResponse, GameError>) -> ()) {
    guard let url = URL(string: "\(baseURL)/\(id)") else {
      completion(.failure(.invalidEndpoint))
      return
    }
    
    self.loadURLAndDecodeData(url: url, completion: completion)
  }
  
  func searchGame(query: String, completion: @escaping (Result<GameResponse, GameError>) -> ()) {
    guard let url = URL(string: baseURL) else {
      completion(.failure(.invalidEndpoint))
      return
    }
    
    let queryItems = [URLQueryItem(name: "search", value: query)]
    
    self.loadURLAndDecodeData(url: url, params: queryItems, completion: completion)
  }
  
  func fetchGameScreenshots(id: Int, completion: @escaping (Result<GameScreenshotResponse, GameError>) -> ()) {
    guard let url = URL(string: "\(baseURL)/\(id)/screenshots") else {
      completion(.failure(.invalidEndpoint))
      return
    }
    
    self.loadURLAndDecodeData(url: url, completion: completion)
  }
  
  func fetchUpcomingGames(completion: @escaping (Result<GameResponse, GameError>) -> ()) {
    guard let url = URL(string: "\(baseURL)") else {
      completion(.failure(.invalidEndpoint))
      return
    }
    
    print(url)
    let queryItems = [
      URLQueryItem(name: "ordering", value: "\(Ordering.popularity)"),
      URLQueryItem(name: "page_size", value: "5"),
      URLQueryItem(name: "dates", value: "\(DateUtils.currentDate),\(DateUtils.nextYear)")
    ]
    
    self.loadURLAndDecodeData(url: url, params: queryItems, completion: completion)
  }
  
  private func loadURLAndDecodeData<T: Decodable>(url: URL, params: [URLQueryItem]? = nil,  completion: @escaping (Result<T, GameError>) -> ()) {
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      completion(.failure(.invalidEndpoint))
      return
    }
    
    urlComponents.queryItems = params
    
    guard let finalURL = urlComponents.url else {
      completion(.failure(.invalidEndpoint))
      return
    }
    
    urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
      guard let self = self else { return }
      
      guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
        self.executeCompletionHandler(with: .failure(.apiError), completion: completion)
        return
      }
      
      guard let data = data else {
        self.executeCompletionHandler(with: .failure(.noData), completion: completion)
        return
      }
      
      do {
        let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
        self.executeCompletionHandler(with: .success(decodedResponse), completion: completion)
      } catch {
        self.executeCompletionHandler(with: .failure(.noData), completion: completion)
      }
      
    }.resume()
  }
  
  private func executeCompletionHandler<T: Decodable>(with result: Result<T, GameError>, completion: @escaping (Result<T, GameError>) -> ()) {
    DispatchQueue.main.async {
      completion(result)
    }
  }
}

private enum Ordering: String {
  case added = "added"
  case rating = "rating"
  case released = "released"
  case popularity = "popularity"
}

struct DateUtils {
  static var currentDate: String {
    let date = Date()
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    return formatter.string(from: date)
  }
  
  static var nextYear: String {
    var dateComponents = DateComponents()
    dateComponents.year = 1
    
    let currentYear = Date()
    let nextYear = Calendar.current.date(byAdding: dateComponents, to: currentYear)!
    
    return nextYear.formatAsString
  }
  
  static var lastMonth: String {
    var dateComponents = DateComponents()
    dateComponents.month = -1
    
    let current = Date()
    let lastMonth = Calendar.current.date(byAdding: dateComponents, to: current);
    
    return lastMonth?.formatAsString ?? ""
  }
}

extension Date {
  var formatAsString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    return formatter.string(from: self)
  }
}
