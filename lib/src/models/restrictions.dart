// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of content restrictions
@JsonSerializable()
class Restrictions extends Object {
  Restrictions();

  factory Restrictions.fromJson(Map<String, dynamic> json) =>
      _$RestrictionsFromJson(json);

  Map<String, dynamic> toJson() => _$RestrictionsToJson(this);

  /// The reason for the restriction.
  /// Possible values: market, product, explicit, or payment_required
  String? reason;
}
