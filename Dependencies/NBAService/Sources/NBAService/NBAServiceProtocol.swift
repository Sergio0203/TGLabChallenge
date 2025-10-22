public protocol NBAServiceProtocol {
    func getTeams() async throws -> [TeamDTO]
    func getGames(forTeamId id: Int, cursor: Int?) async throws -> [GameDTO]
    func getPlayers(withName name: String) async throws -> [PlayerDTO]
}
