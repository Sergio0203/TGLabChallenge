# TGLabChallenge

This native iOS app was built with Swift and SwiftUI as part of the TGLab challenge. It uses the balldontlie.io API to display information about NBA teams, players, and games.

## API Rate Limit Handling

This project uses the free tier of the balldontlie.io API, which has a limit of 5 requests/minute(https://docs.balldontlie.io/#nba-api)

To handle this, the app was designed to manage rate-limiting errors. If the API limit is hit (error 429), the app will display a loading indicator and automatically retry the request until it succeeds.

## Requirements

Minimum iOS Target: 26

Developed with: Xcode 26 (or higher, due to the use of @Observable macros)

## Contact

If you have any problems to run the project or questions about it, please reach me:

Email: sergiocesar0203@gmail.com
