//
//  RealmExtensions.swift
//  Data_Realm
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

extension SortDescriptor {
    init(sortDescriptor: NSSortDescriptor) {
        self.init(keyPath: sortDescriptor.key ?? "", ascending: sortDescriptor.ascending)
    }
}

extension Reactive where Base: Realm {
    func save<R>(entities: [R], update: Bool = true) -> Completable where R: Object  {
        return Completable.create { completable -> Disposable in
            do {
                try self.base.write {
                    self.base.add(entities, update: update)
                }
                completable(.completed)
            } catch {
                completable(.error(error))
            }
            return Disposables.create()
        }
    }

    func delete<R>(entities: [R]) -> Completable where R: Object {
        return Completable.create { completable -> Disposable in
            do {
                try self.base.write {
                    self.base.delete(entities)
                }
                completable(.completed)
            } catch {
                completable(.error(error))
            }
            return Disposables.create()
        }
    }
}
