import Foundation

// MARK: Domains
public struct Domains: Decodable {
  public let data: [Domain]
}

// MARK: - Domain
public struct Domain: Decodable {
  public let attributes: Attributes
}

// MARK: - Attributes
public struct Attributes: Decodable {
  public let name: String
  public let description: String
  public let level: String
}
