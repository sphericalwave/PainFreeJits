//
//  Error+Extension.swift
//  App
//
//  Created by Aaron Anthony on 2020-07-16.
//

import Vapor
import FluentKit

extension Error
{
    func isDatabaseConstraintFailure<T: Model>(for properties: FieldProperty<T, UUID>...) -> Bool {
        return isDatabaseConstraintFailure(on: T.self, for: properties.map { $0.key })
    }

    func isDatabaseConstraintFailure<T: Model>(for properties: FieldProperty<T, String>...) -> Bool {
        return isDatabaseConstraintFailure(on: T.self, for: properties.map { $0.key })
    }

    func isDatabaseConstraintFailure<T: Model>(for a: FieldProperty<T, UUID>, _ b: OptionalFieldProperty<T, UUID>) -> Bool {
        return isDatabaseConstraintFailure(on: T.self, for: [a.key, b.key])
    }

    func isDatabaseConstraintFailure<T: Model>(for a: FieldProperty<T, UUID>, _ b: FieldProperty<T, String>) -> Bool {
        return isDatabaseConstraintFailure(on: T.self, for: [a.key, b.key])
    }

    // MARK: - Private

    private func isDatabaseConstraintFailure<T: Model>(on model: T.Type = T.self, for fields: [FieldKey]) -> Bool {
        guard let error = self as? DatabaseError,
            error.isConstraintFailure else { return false }

        return fields.allSatisfy { localizedDescription.contains("\(model.schema).\($0)") }
    }
}

//Example Usage
//item.create(on: db)
//.flatMapErrorThrowing { error in
//    if error.isDatabaseConstraintFailure(for: item.$list.$id, item.$movie.$id) {
//        throw ListItemError.duplicateListItem(.movie)
//    } else if error.isDatabaseConstraintFailure(for: item.$list.$id, item.$tvSeries.$id) {
//        throw ListItemError.duplicateListItem(.tvSeries)
//    }
//
//    throw error
//}
