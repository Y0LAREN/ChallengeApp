//
//  SchemaV1.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 07.02.2025.
//

import SwiftData

typealias CurrentScheme = SchemaV1

enum SchemaV1: VersionedSchema {
  public static var versionIdentifier: Schema.Version {
    .init(1, 0, 0)
  }

  static var models: [any PersistentModel.Type] {
      [ChallengeModel.self, NoteModel.self]
  }
}
