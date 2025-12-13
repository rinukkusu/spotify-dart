# GitHub Issues Review - December 2025

**Date**: 2025-12-13
**Repository**: spotify-dart
**Total Open Issues**: 16

## Executive Summary

| Category | Count | Issues |
|----------|-------|--------|
| **Completed** | 7 | #225 (PR #229), #216 (PR #230), #221 (PR #231), #170 (PR #231), #176 (PR #231), #196 (Closed), #81 (Closed) |
| **Awaiting Confirmation** | 1 | #69 |
| **Quick Fixes** | 0 | - |
| **Enhancements** | 4 | #133, #181, #75, #197 |
| **Feature Requests** | 3 | #168, #186, #172 |
| **Documentation** | 3 | #151, #79, #138 |

---

## Issues by Status

### 🔴 URGENT - Immediate Action Required

#### [#225](https://github.com/rinukkusu/spotify-dart/issues/225) - Deprecated Spotify APIs
**Status**: ✅ COMPLETED - PR #229
**Action**: Add `@deprecated` annotations
**Priority**: HIGH
**Affected**: AudioAnalysis, AudioFeatures, Recommendations endpoints

**Details**:
- Verified via Spotify API documentation that `/audio-features/{id}` and `/recommendations` are officially deprecated
- Added `@Deprecated` annotations to all affected endpoint classes and methods
- Added ignore comments to suppress warnings in library's own code

**Completed**:
- Added deprecation annotations to `lib/src/endpoints/audio_analysis.dart`
- Added deprecation annotations to `lib/src/endpoints/audio_features.dart`
- Added deprecation annotations to `lib/src/endpoints/recommendations.dart`
- Suppressed warnings in `lib/src/spotify_base.dart`
- PR: https://github.com/rinukkusu/spotify-dart/pull/229

---

### ✅ Closed Issues

#### [#196](https://github.com/rinukkusu/spotify-dart/issues/196) - Auth without user redirect
**Status**: ✅ CLOSED - Already Supported
**Closed**: 2025-12-13
**Answer**: Client Credentials Flow is already implemented

The library supports client credentials flow (no user redirect needed):
```dart
final credentials = SpotifyApiCredentials(clientId, clientSecret);
final spotify = SpotifyApi(credentials);
```
This is shown in `example/example.dart:14` and works for accessing public data without user authorization.

#### [#81](https://github.com/rinukkusu/spotify-dart/issues/81) - PKCE Support
**Status**: ✅ CLOSED - Already Works
**Closed**: 2025-12-13
**Answer**: PKCE is automatically enabled when passing `null` for clientSecret

The oauth2 library automatically uses PKCE flow when clientSecret is null:
```dart
final credentials = SpotifyApiCredentials(clientId, null);
```

### ⏳ Awaiting Confirmation

#### [#69](https://github.com/rinukkusu/spotify-dart/issues/69) - Error fetching playlists
**Status**: Likely Fixed - Awaiting User Confirmation
**Action**: Commented 2025-12-13
**Original Report**: 2020-07-23

This issue reports broken iterables when fetching playlists. The v0.13.7 changelog includes a fix:
> "add filter function for playlist endpoint to prevent deserialization of tracks that are `null`"

Commented asking if still reproducible in v0.14.0. Will close if confirmed fixed or no response after reasonable timeframe.

---

### 🔧 Quick Fixes

#### [#216](https://github.com/rinukkusu/spotify-dart/issues/216) - Replace assert with ArgumentError
**Status**: ✅ COMPLETED - PR #230
**Priority**: Medium
**Complexity**: Low - Good First Issue

**Problem**: 40 assert statements across 9 files only work in debug mode and are stripped in production builds.

**Completed**:
- Replaced 40 assert statements with `ArgumentError` and `RangeError`
- Collection/string emptiness checks (26) → `ArgumentError`
- Bounded range checks (4) → `RangeError.range(value, min, max, param)`
- Lower bound range checks (6) → `RangeError.range(value, 0, null, param)`
- Mutual exclusivity (1) → `ArgumentError`
- Enum validation (2) → `ArgumentError.value`
- PR: https://github.com/rinukkusu/spotify-dart/pull/230

#### [#221](https://github.com/rinukkusu/spotify-dart/issues/221) + [#170](https://github.com/rinukkusu/spotify-dart/issues/170) + [#176](https://github.com/rinukkusu/spotify-dart/issues/176) - TrackSimple Missing Fields
**Status**: ✅ COMPLETED - PR #231
**Priority**: Medium

**Problem**: Spotify API returns full Track objects but library used TrackSimple, discarding album and popularity fields.

**Completed**:
- Changed `PlayHistory.track` from `TrackSimple?` to `Track?`
- Changed `Recommendations.tracks` from `List<TrackSimple>?` to `List<Track>?`
- Updated test fixture with album and popularity fields
- Added test assertions for new fields
- PR: https://github.com/rinukkusu/spotify-dart/pull/231

---

### 🚀 Enhancements Needed

#### [#133](https://github.com/rinukkusu/spotify-dart/issues/133) - PlayHistory artist images null
**Status**: Needs Investigation
**Priority**: Medium

**Problem**: Artist images are null in PlayHistory tracks.

**Note**: This is a SEPARATE issue from #221/#170/#176. Research shows `TrackSimple.artists` is already typed as `List<Artist>` (not `ArtistSimple`), so the null images may be due to Spotify API not returning full Artist objects in the response. Requires further investigation of actual API responses.

#### [#181](https://github.com/rinukkusu/spotify-dart/issues/181) - Support episodes in playlists
**Status**: Valid Enhancement
**Priority**: Medium

**Problem**: `getPlaylistTracks()` restricts to `additional_types: 'track'`, excluding episodes.

**Solution**: Make `additional_types` parameter configurable to support both tracks and episodes.

**File**: `lib/src/endpoints/playlists.dart:52-63`

#### [#75](https://github.com/rinukkusu/spotify-dart/issues/75) - Date-based paging
**Status**: Partially Implemented
**Priority**: Low

`me.recentlyPlayed()` supports `after` and `before` timestamp parameters. The issue requests generalizing this pattern to the `EndpointPaging` class for reuse.

#### [#197](https://github.com/rinukkusu/spotify-dart/issues/197) - BaseResponseWithUrl
**Status**: Enhancement - May Need http 2.0
**Priority**: Low

Waiting for Dart's `http` package 2.0 which includes URL in BaseResponse. Would help with authorization flow improvements.

---

### 📦 Feature Requests

#### [#168](https://github.com/rinukkusu/spotify-dart/issues/168) - Audiobooks & Chapters
**Status**: Valid Feature Request
**Priority**: Low

Spotify added `/audiobooks` and `/chapters` endpoints. No models or endpoint implementations exist in the library yet.

#### [#186](https://github.com/rinukkusu/spotify-dart/issues/186) - Debug Tools
**Status**: Valid Feature Request
**Priority**: Low

Request for:
- HTTP request/response logging
- Request tracking and history
- Different logging levels

#### [#172](https://github.com/rinukkusu/spotify-dart/issues/172) - Organize Model Classes
**Status**: Architectural Discussion
**Priority**: Low

Proposes refactoring models using:
- `SpotifyContentBase` and `SpotifyContent` base classes
- Mixins for shared properties (Copyright, ExternalUrls, etc.)
- Reduced code duplication

Large architectural change - keep open for community discussion.

---

### 📚 Documentation Needs

#### [#151](https://github.com/rinukkusu/spotify-dart/issues/151) - Code Conventions
**Status**: Valid Documentation Need
**Priority**: Medium

Requests `CONTRIBUTING.md` with:
- Code conventions and style guide
- When to use getters vs methods
- Guidelines for new contributors

#### [#79](https://github.com/rinukkusu/spotify-dart/issues/79) - Wiki Documentation
**Status**: Ongoing Documentation Task
**Priority**: Low

Task to document all implemented endpoints in the wiki. Good ongoing community contribution opportunity.

#### [#138](https://github.com/rinukkusu/spotify-dart/issues/138) - Sort by Popularity
**Status**: Needs Clarification
**Priority**: Low

User asks how to combine and sort different content types from search results by popularity. May need clarification or just documentation.

---

## Recommended Action Plan

### Phase 1: Immediate (High Priority) ✅ COMPLETED
1. ✅ **COMPLETED** - #225 (Spotify deprecated APIs) - PR #229
2. ✅ **COMPLETED** - Closed #196, #81; Commented on #69

### Phase 2: Quick Wins (Medium Priority) ✅ COMPLETED
3. ✅ **COMPLETED** - #216 (Replace 40 assert statements) - PR #230
4. ✅ **COMPLETED** - #221 + #170 + #176 (TrackSimple to Track) - PR #231
5. 🔧 Fix #181 (Episode support in playlists)

### Phase 3: Documentation (Medium Priority)
6. 📝 Create CONTRIBUTING.md (#151)
7. 📝 Respond to #138 with clarification request

### Phase 4: Long-term (Low Priority)
8. Keep open: #168, #186, #172 (Feature requests for community)
9. Keep open: #79 (Ongoing documentation)
10. Keep open: #75, #197 (Enhancements)

---

## Related Issues Map

```
Completed (PR #231):
├─ #221 - Change to Track in PlayHistory ✅
├─ #170 - Add album field to TrackSimple ✅
└─ #176 - Missing album in Recommendations ✅

Closed (Already Supported):
├─ #196 - Client credentials flow ✅
├─ #81 - PKCE support ✅
└─ #69 - Awaiting confirmation if fixed

Remaining Enhancements:
├─ #133 - Artist images null (separate issue, needs investigation)
└─ #181 - Episode support in playlists
```

---

## Files Requiring Attention

| Priority | Files | Issue |
|----------|-------|-------|
| Medium | `lib/src/endpoints/playlists.dart:52-63` | #181 |
| Low | `lib/src/models/user.dart` | #133 (investigation needed) |

---

**Generated**: 2025-12-12
**Last Updated**: 2025-12-13 (PR #231 merged)
**Reviewer**: Claude Code
**Next Review**: Recommend quarterly review of open issues
