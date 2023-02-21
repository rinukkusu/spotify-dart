// Copyright (c) 2020, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Device extends Object {
  Device();

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  /// The device ID. This may be [null].
  String? id;

  @JsonKey(name: 'is_active', defaultValue: false)
  bool? isActive;

  /// Whether controlling this device is restricted.
  /// At present if this is [true] then no Web API commands will be
  /// accepted by this device.
  @JsonKey(name: 'is_private_session', defaultValue: false)
  bool? isPrivateSession;

  /// Whether controlling this device is restricted.
  /// At present if this is [true] then no Web API commands will be accepted by this device.
  @JsonKey(name: 'is_restricted', defaultValue: false)
  bool? isRestricted;

  /// The name of the device
  String? name;

  /// [DeviceType], such as [Computer], [Smartphone] or [Speaker].
  DeviceType? type;

  /// The current volume in percent. This may be null.
  @JsonKey(name: 'volume_percent')
  int? volumePercent;
}

enum DeviceType {
  Computer,
  Tablet,
  Smartphone,
  Speaker,
  TV,
  AVR,
  STB,
  AudioDongle,
  GameConsole,
  CastVideo,
  CastAudio,
  Automobile,
  Unknown
}
