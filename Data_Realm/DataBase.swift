//
//  DataBase.swift
//  Data_Realm
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import RxRealm

public final class DataBase: DataBaseProvider {
    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler

    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }

    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
        let name = "com.ctw.challenge"
        self.scheduler = RunLoopThreadScheduler(threadName: name)
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }

    public func queryAll<T: Object>(_ type: T.Type) -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(type)

            return Observable.array(from: objects)
            }
            .subscribeOn(scheduler)
    }

    public func query<T: Object>(type: T.Type, withPredicate predicate: NSPredicate,
                                 sortDescriptors: [NSSortDescriptor]) -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(type)
                .filter(predicate)
                .sorted(by: sortDescriptors.map(SortDescriptor.init))
            return Observable.array(from: objects)
            }
            .subscribeOn(scheduler)
    }

    public func save<T: Object>(entity: T) -> Completable {
        return self.save(entities: [entity])
    }

    public func save<T: Object>(entities: [T]) -> Completable {
        return Completable.deferred {
            return self.realm.rx.save(entities: entities)
            }.subscribeOn(scheduler)
    }

    public func delete<T: Object>(entity: T) -> Completable {
        return self.delete(entities: [entity])
    }

    public func delete<T: Object>(entities: [T]) -> Completable {
        return Completable.deferred {
            return self.realm.rx.delete(entities: entities)
            }.subscribeOn(scheduler)
    }
}
