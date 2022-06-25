//
//  Sequence.ConditionalGrouping.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 1/1/22.
//

import Foundation

// MARK: - Sequence Conditional Grouping
extension Sequence {
    /// Groups elements of a `Sequence` by a given predicate.
    ///
    /// Works similar to `Dictionary(grouping:by:)`, but without generating keys.
    /// In addition to similar begavior, allows for a custom logic to be written, as generating a specific key is not required.
    ///
    ///     let students: [String] = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
    ///     let studentsByLetter: [[String]] = students.grouped(by: { $0.first == $1.first })
    ///
    ///     // [["Kofi", "Kweku"], ["Abena", "Akosua"], ["Efua"]]
    ///
    public func grouped(
        by comparison: @escaping (Element, Element) throws -> Bool
    ) rethrows -> [[Element]] {
        var result: [[Element]] = []
        
        for element in self {
            if
                !result.isEmpty,
                let index: Int = try result.firstIndex(where: { group in
                    guard let firstGroupElement: Element = group.first else { return false }
                    return try comparison(firstGroupElement, element)
                })
            {
                result[index].append(element)
            } else {
                result.append([element])
            }
        }
        
        return result
    }
    
    /// Groups elements of a `Sequence` by a given `KeyPath` value.
    ///
    /// Works similar to `Dictionary(grouping:by:)`, but without generating keys.
    /// In addition to similar begavior, allows for a custom logic to be written, as generating a specific key is not required.
    ///
    ///     struct Student {
    ///         let name: String
    ///         var firstChar: Character { name.first! }
    ///     }
    ///
    ///     let students: [Student] = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"].map { .init(name: $0) }
    ///     let studentsByLetter: [[Student]] = students.grouped(by: \.firstChar)
    ///
    ///     // [[Student(name: "Kofi"), Student(name: "Kweku")], [Student(name: "Abena"), Student(name: "Akosua")], [Student(name: "Efua")]]
    ///
    public func grouped<Property>(
        by keyPath: KeyPath<Element, Property>
    ) -> [[Element]]
        where Property: Equatable
    {
        grouped(by: { (lhs, rhs) in
            lhs[keyPath: keyPath] == rhs[keyPath: keyPath]
        })
    }
}
