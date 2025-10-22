// The Swift Programming Language
// https://docs.swift.org/swift-book
//
import Client
public struct NBAService {
    private let client: ClientProtocol

    public init() {
        self.client = UrlSessionClient()
    }

    init (client: ClientProtocol = UrlSessionClient()) {
        self.client = client
    }

    public func getTeams() async throws -> [TeamDTO] {
        let response: APIResponse<[TeamDTO]> = try await client.request(NBAAPIEndpoint.getTeams)
        return response.data
    }

    public func getGames(forTeamId id: Int, cursor: Int? = nil) async throws -> [GameDTO] {
        let response: APIResponse<[GameDTO]> = try await client.request(NBAAPIEndpoint.getGames(teamID: id, cursor: cursor))
        return response.data
    }

    public func getPlayers(withName name: String) async throws -> [PlayerDTO] {
        let response: APIResponse<[PlayerDTO]> = try await client.request(NBAAPIEndpoint.searchPlayers(name: name))
        return response.data
    }
}
