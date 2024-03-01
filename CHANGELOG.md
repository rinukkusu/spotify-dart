# Changelog

## 0.13.2

- add codeVerifier for oauth flow
- add method to expand spotify's shortened URLs 
  - e.g. `await spotify.expandLink('https://spotify.link/hRkBrwub9xb')`

## 0.13.1

- fix empty playbackState returning 404

## 0.13.0

- fix unknown devices bug
- add tracks restriction on playlist items
- deprecate `startOrResume` in favor of starting with tracks or context and a new resume method
- fix spotify floating point bug on integer fields (temp)

## 0.12.0

- improve authorization scope handling
- add audio analysis endpoint
- add transfer playback endpoint
- improve usage of Market throughout exposed library code
- upgrade dependencies and enable Dart SDK 3.0 compatibility

## 0.11.0

- remove deprecated library entrypoints
- add/fix doc comments
- add v1/playlists/$playlistId/tracks related methods

## 0.10.0

- add more documentation
- refactor library organization
- add episodes methods to `me` endpoint
- add episodes endpoint
- add player methods for controlling playback
- refactor player methods out of `me` endpoint

## 0.9.1

- bump dependency versions
- regenerate serialization models

## 0.9.0

- add new-releases endpoint
- add queue endpoints for retrieving and adding
- fix nullability and static analysis issues
- fix search endpoint and examples
- add shows related endpoints
- deprecate `isSavedAlbums` and prefer usage of `containsSavedAlbums`

## 0.8.0

- add playlists endpoint for specific users
- add distinct cursor and offset paging classes

## 0.7.3

- fix `isLast` in paging endpoint

## 0.7.2

- add update playlist endpoint
- add docs for serverside auth token refresh

## 0.7.1

- several bug fixes
- add async factory for `SpotifyApi`
- add follow/unfollow artists and users endpoints
- add inserting track in playlist endpoint
- add remove tracks endpoint

## 0.7.0

- create client with access token only
- add description field to playlist model

## 0.6.0

- fix following artist
- add user saved shows endpoint
- fix episode listing
- clean up album models
- add null safety

## 0.5.1

- add createPlaylist optional parameters

## 0.5.0

- add tracks to album response
- add credentials refresh callback

## 0.4.0

- implement podcast endpoints 

## 0.3.7+1

- fix recentlyPlayed endpoint and add unit tests

## 0.3.7

- add /me/top/artists endpoint
- add following and unfollowing playlists
- add date-based paging to /me/recentlyPlayed

## 0.3.6

- AlbumSimple: add release date properties
- add authorization flow for saved credentials

## 0.3.5

- playlists: support adding multiple tracks to playlist

## 0.3.4

- add /me/following endpoint

## 0.3.3

- search: add market parameter
- add request rate handling with retries

## 0.3.2

- users: move `me` calls to own endpoint class
    - `me` calls in `users` endpoint class will be removed in the next releases
- artists: add albums call

## 0.3.1+3

- album: remove object type detection hack

## 0.3.1+2

- fix minor bug introduced by #43

## 0.3.1+1

- fix audio-features parsing issue

## 0.3.1

- fix compilation issue with test client #44
- improve recommendation, tracks and playlist endpoints #43
- improve readme regarding authorization #41
- add method to retrieve oauth2 credentials #38
- add devices call #36

## 0.3.0

- unify package's Browser and IO exports, fix invalid SDK error #34
- improve static analysis health #33

## 0.2.1

- add oauth2 package for refresh flow
- fix pagination on several places
- add playlists/removeTrack
- add playlists/addTrack
- add createPlaylist
- fix my playlists
- refactor SpotifyApi classes
- upgrade json_serializable dependencies

## 0.2.0

- add token setter method for implicit grant
- add related artists
- add recently played artists
- add top tracks
- add categories
- add tracksByPlaylist
- fix currently playing

Please don't mind the weird commit history, I goofed and used rebase first and merge on the later pull requests.

## 0.1.6+3

- fix typo in tracks object
- move album model switch to model

## 0.1.5+1

- add external_ids and external_urls

## 0.1.4

- add related-artists to the artists endpoint

## 0.1.3+2

- use full Track object in search endpoint

## 0.1.3+1

- eliminate duplicate code (serializers)

## 0.1.3

- add currently playing endpoint

## 0.1.2

- make pub analyzer happy

## 0.1.1

- add search endpoint

## 0.0.9 - 0.1.0

- support Dart 2 with switch to json_serializable

## 0.0.8

- add missing _putImpl implementation to SpotifyMock

## 0.0.7

- add user's saved tracks endpoints

## 0.0.6

- add pagination support

## 0.0.5

- add user and playlist endpoints

## 0.0.4

- fix typo in artists endpoint
- add basic unit tests

## 0.0.3

- add support for albums and artists
- refactor code a little

## 0.0.1

- Initial version
