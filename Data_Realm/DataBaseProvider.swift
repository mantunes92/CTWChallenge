//
//  DataBaseProvider.swift
//  Data_Realm
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

public protocol DataBaseProvider {
    func queryAll<T: Object>(_ type: T.Type) -> Observable<[T]>
    func query<T: Object>(type: T.Type, withPredicate predicate: NSPredicate,
                          sortDescriptors: [NSSortDescriptor]) -> Observable<[T]>
    func save<T: Object>(entity: T) -> Completable
    func save<T: Object>(entities: [T]) -> Completable
    func delete<T: Object>(entity: T) -> Completable
    func delete<T: Object>(entities: [T]) -> Completable
}
