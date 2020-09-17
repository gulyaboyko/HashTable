//
//  HashTable.swift
//  HashTable
//
//  Created by Gulya Boiko on 9/17/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation

final class HashEntry<K: Hashable, V> {
    let key: K
    var value: V
    var next: HashEntry?
    
    init(key: K, value: V) {
        self.key = key
        self.value = value
    }
}

final class HashTable<K: Hashable, V> {
    static private var default_capacity: Int { return 11 }
    static private var default_load_factor: Double { return 0.75 }
    
    private var buckets: [HashEntry<K, V>?] = Array(repeating: nil, count: HashTable.default_capacity)
    
    private var threshold = HashTable.default_capacity * Int(HashTable.default_load_factor)
    private let loadFactor = HashTable.default_load_factor
    private (set) var size = 0
    
    func get(key: K) -> V? {
        let idx = hash(key)
        var e = buckets[idx]
        while e != nil {
            if (e?.key == key) {
                return e?.value
            } else {
                e = e?.next
            }
        }
        return nil
    }
    
    @discardableResult
    func put(key: K, value: V) -> V? {
        var idx = hash(key)
        var e = buckets[idx]
        // если в текущей корзине уже есть элементы
        while e != nil {
            if e?.key == key {
                // проверка есть ли уже такой же ключ
                // замена значения и возврат предыдущего значения
                let r = e?.value
                e?.value = value
                return r
            } else {
                e = e?.next
            }
        }
        size += 1
        if size == threshold {
            rehash()
            idx = hash(key)
        }
        // TODO - rehash if needed
        e = HashEntry(key: key, value: value)
        e?.next = buckets[idx]
        buckets[idx] = e
        return nil
    }
    
    func remove(key: K) -> V? {
        let idx = hash(key)
        var e = buckets[idx]
        var last: HashEntry<K, V>? = nil
        while e != nil {
            if e?.key == key {
                // удалить
                let next = e?.next
                if last == nil {
                    buckets[idx] = next
                } else {
                    last?.next = next
                }
                size -= 1
                return e?.value
            } else {
                last = e
                e = e?.next
            }
        }
        return nil
    }
    
    // Private function
    private func hash(_ key: K) -> Int {
        return abs(key.hashValue % buckets.count)
    }
    
    private func rehash() {
        let oldBuckets = buckets
        let newCapacity = buckets.count * 2 + 1
        threshold = Int(loadFactor) * newCapacity
        buckets = Array(repeating: nil, count: newCapacity)
        for i in stride(from: oldBuckets.count-1, to: 0, by: -1) {
            var e = oldBuckets[i]
            while e != nil {
                let ids = hash(e.unsafelyUnwrapped.key)
                var dest = buckets[ids]
                if dest != nil { // что-то уже лежит в корзине
                    var next = dest?.next // второй элемент в списке
                    while next != nil { // продвигаемся в конец
                        dest = next
                        next = dest?.next
                    }
                    dest?.next = e // в самый конец записываем элемент - для сохранения порядка
                } else {
                    buckets[ids] = e
                }
                let next = e?.next
                e?.next = nil
                e = next
            }
        }
    }
    
}
