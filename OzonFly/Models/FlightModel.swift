
import Foundation


struct FlightModel: Codable {
    let flights: [Flights]
}

struct Flights: Codable, Hashable {
    let uuid = UUID()
    private enum CodingKeys : String, CodingKey { case startDate, endDate, startLocationCode, endLocationCode, startCity, endCity, serviceClass, seats, price, searchToken  }
    
    let startDate: String
    let endDate: String
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String
    let seats: [Seats]
    let price: Int
    let searchToken: String
}

struct Seats: Codable, Hashable {
    let passengerType: String
    let count: Int
}

extension Flights{
    static func ==(lhs: Flights, rhs: Flights) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
