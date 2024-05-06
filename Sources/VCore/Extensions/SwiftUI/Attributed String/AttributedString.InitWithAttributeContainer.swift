//
//  AttributedString.InitWithAttributeContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.02.24.
//

import SwiftUI
import OSLog

// MARK: - Attributed String Init with Attribute Containers
extension AttributedString {
    /// Initializes `AttributedString` with child `AttributedString` components created from mapping tag names to `AttributeContainer`s.
    ///
    ///     var body: some View {
    ///         Text(
    ///             AttributedString(
    ///                 string: "Lorem <a>ipsum dolor</a> sit amet, <b>consectetur adipiscing</b> elit",
    ///                 attributeContainers: [
    ///                     "a": {
    ///                         var container: AttributeContainer = .init()
    ///                         container.foregroundColor = .red
    ///                         container.font = .title.weight(.ultraLight)
    ///                         return container
    ///                     }(),
    ///                     "b": {
    ///                         var container: AttributeContainer = .init()
    ///                         container.foregroundColor = .blue
    ///                         container.font = .callout.weight(.bold)
    ///                         return container
    ///                     }()
    ///                 ]
    ///             )
    ///         )
    ///         .multilineTextAlignment(.center)
    ///         .foregroundStyle(.primary)
    ///         .font(.body)
    ///         .padding(.horizontal)
    ///     }
    ///
    public init(
        string: String,
        attributeContainers: [Character: AttributeContainer]
    ) {
        let tagNames: [Character] = .init(attributeContainers.keys)
        let components: [(tagName: Character?, substring: String)] = string.components(separatedByTagNames: tagNames)

        var result: AttributedString = .init()

        for component in components {
            var attributedString: AttributedString = .init(component.substring)

            if
                let tagName: Character = component.tagName,
                let attributeContainer: AttributeContainer = attributeContainers[tagName]
            {
                attributedString.setAttributes(attributeContainer)
            }

            result.append(attributedString)
        }

        self = result
    }
}

// MARK: - String Components Separated by Tags
extension String {
    /*fileprivate*/ func components(
        separatedByTagNames tagNames: [Character]
    ) -> [(tagName: Character?, substring: String)] {
        // Input:
        // "Lorem <a>ipsum dolor</a> sit amet, <b>consectetur adipiscing</b> elit"
        //
        // Output:
        // [
        //     (nil: "Lorem "),
        //     ("a": "ipsum dolor"),
        //     (nil: " sit amet "),
        //     ("b": "consectetur adipiscing"),
        //     (nil: " elit")
        // ]

        var result: [(tagName: Character?, substring: String)] = []

        var index: Int = 0
        var isInsideTag: Bool = false
        var currentTagName: Character?
        var currentSubstring: String = ""

        while index < count {
            if
                !isInsideTag,
                index + 2 < count,
                self[index] == "<",
                tagNames.contains(self[index+1]),
                self[index+2] == ">"
            {
                if !currentSubstring.isEmpty {
                    result.append((tagName: nil, substring: currentSubstring))
                }

                isInsideTag = true
                currentTagName = self[index+1]
                currentSubstring = ""
                index += 3

            } else if
                isInsideTag,
                index + 3 < count,
                self[index] == "<",
                self[index+1] == "/",
                self[index+2] == currentTagName,
                self[index+3] == ">"
            {
                result.append((self[index+2], currentSubstring))

                isInsideTag = false
                currentTagName = nil
                currentSubstring = ""
                index += 4

            } else {
                currentSubstring.append(self[index])

                index += 1
            }
        }

        // Terminates existing un-attributed component
        if !currentSubstring.isEmpty {
            result.append((tagName: nil, substring: currentSubstring))
        }

        return result
    }
}


// MARK: - Preview
#if DEBUG

#Preview(body: {
    Text(
        AttributedString(
            string: "Lorem <a>ipsum dolor</a> sit amet, <b>consectetur adipiscing</b> elit",
            attributeContainers: [
                "a": {
                    var container: AttributeContainer = .init()
                    container.foregroundColor = .red
                    container.font = .title.weight(.ultraLight)
                    return container
                }(),
                "b": {
                    var container: AttributeContainer = .init()
                    container.foregroundColor = .blue
                    container.font = .callout.weight(.bold)
                    return container
                }()
            ]
        )
    )
    .multilineTextAlignment(.center)
    .foregroundStyle(.primary)
    .font(.body)
    .padding(.horizontal)
})

#endif
