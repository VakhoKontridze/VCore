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
    ///     let string: String = "Lorem <b>ipsum dolor</b> sit amet, <c>consectetur adipiscing</c> elit"
    ///
    ///     let attributeContainers: [Character: AttributeContainer] = [
    ///         "b": {
    ///             var container: AttributeContainer = .init()
    ///             container.foregroundColor = .red
    ///             container.font = .title.weight(.ultraLight)
    ///             return container
    ///         }(),
    ///         "c": {
    ///             var container: AttributeContainer = .init()
    ///             container.foregroundColor = .blue
    ///             container.font = .callout.weight(.bold)
    ///             return container
    ///         }()
    ///     ]
    ///
    ///     let attributedString: AttributedString = {
    ///         do {
    ///             return try AttributedString(string, attributeContainers: attributeContainers)
    ///         } catch {
    ///             return AttributedString(string)
    ///         }
    ///     }()
    ///
    ///     var body: some View {
    ///         Text(attributedString)
    ///             .multilineTextAlignment(.center)
    ///             .foregroundStyle(.primary)
    ///             .font(.body)
    ///             .padding(.horizontal)
    ///     }
    ///
    public init(
        _ string: String,
        attributeContainers: [Character: AttributeContainer]
    ) throws {
        let tagNames: [Character] = .init(attributeContainers.keys)
        let components: [(tagName: Character?, substring: String)] = try string.components(separatedByTagNames: tagNames)

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

    /// Initializes `AttributedString` with child `AttributedString` components created from mapping tag names to `AttributeContainer`s.
    ///
    ///     var body: some View {
    ///         Text(
    ///             AttributedString(
    ///                 defaultingIfError: "Lorem <b>ipsum dolor</b> sit amet, <c>consectetur adipiscing</c> elit",
    ///                 attributeContainers: [
    ///                     "b": {
    ///                         var container: AttributeContainer = .init()
    ///                         container.foregroundColor = .red
    ///                         container.font = .title.weight(.ultraLight)
    ///                         return container
    ///                     }(),
    ///                     "c": {
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
        defaultingIfError string: String,
        attributeContainers: [Character: AttributeContainer]
    ) {
        do {
            self = try AttributedString(string, attributeContainers: attributeContainers)

        } catch {
            Logger.misc.debug("Failed to create 'AttributedString' with 'AttributeContainer's in 'AttributedString.init(defaultingIfError:attributeContainers:)'. Defaulting to 'AttributedString(string)' expression.")
            self = AttributedString(string)
        }
    }
}

// MARK: - String Components Separated by Tags
extension String {
    /*fileprivate*/ func components(
        separatedByTagNames tagNames: [Character]
    ) throws -> [(tagName: Character?, substring: String)] {
        // Input:
        // "Lorem <b>ipsum dolor</b> sit amet, <c>consectetur adipiscing</c> elit"
        //
        // Output:
        // [
        //     (nil: "Lorem "),
        //     ("b": "ipsum dolor"),
        //     (nil: " sit amet "),
        //     ("c": "consectetur adipiscing"),
        //     (nil: " elit")
        // ]

        var result: [(tagName: Character?, substring: String)] = []

        var index: Int = 0
        var isInsideTag: Bool = false
        var currentTagName: Character?
        var currentSubstring: String = ""

        while index < count {
            let char: Character = self[index]

            switch char {
            case "<":
                // Character is inside the tag, and component can be closed
                if isInsideTag {
                    guard index + 3 < count else {
                        throw StringComponentsSeparatedByTagsError(.invalidClosingTag)
                    }

                    if
                        tagNames.contains(self[index+1]),
                        self[index+1] != currentTagName
                    {
                        throw StringComponentsSeparatedByTagsError(.nestedTagsNotSupported)
                    }

                    guard self[index+1] == "/" else {
                        throw StringComponentsSeparatedByTagsError(.closingTagSlashNotFound)
                    }

                    guard let tagName: Character = tagNames.first(where: { $0 == self[index+2] }) else {
                        throw StringComponentsSeparatedByTagsError(.closingTagNameNotFound)
                    }

                    guard self[index+3] == ">" else {
                        throw StringComponentsSeparatedByTagsError(.invalidClosingTag)
                    }

                    result.append((tagName: tagName, substring: currentSubstring))

                    isInsideTag = false
                    currentTagName = nil
                    currentSubstring = ""
                    index += 1+3 // Skips the entire tag

                // Character is beginning a new component
                } else {
                    // Terminates existing un-attributed component
                    if !currentSubstring.isEmpty {
                        result.append((tagName: nil, substring: currentSubstring))
                        currentSubstring = ""
                    }

                    guard index + 2 < count else {
                        throw StringComponentsSeparatedByTagsError(.invalidOpeningTag)
                    }

                    guard self[index+1] != "/" else {
                        throw StringComponentsSeparatedByTagsError(.slashFoundInOpeningTag)
                    }

                    guard let tagName: Character = tagNames.first(where: { $0 == self[index+1] }) else {
                        throw StringComponentsSeparatedByTagsError(.openingTagNameNotFound)
                    }

                    guard self[index+2] == ">" else {
                        throw StringComponentsSeparatedByTagsError(.invalidOpeningTag)
                    }

                    isInsideTag = true
                    currentTagName = tagName
                    currentSubstring = ""
                    index += 1+2 // Skips the entire tag
                }

            case ">":
                if index == 0 {
                    throw StringComponentsSeparatedByTagsError(.invalidClosingTag)

                } else { // Will never occur, as it's skipped
                    Logger.misc.fault("Unhandled edge-case in 'String.components(separatedByTagNames:)'")
                    throw StringComponentsSeparatedByTagsError(.unknownErrorOccurred)
                }

            default:
                currentSubstring.append(char)
                index += 1
            }
        }

        if isInsideTag { // Will never occur
            Logger.misc.fault("Unhandled edge-case in 'String.components(separatedByTagNames:)'")
            throw StringComponentsSeparatedByTagsError(.unknownErrorOccurred)
        }

        // Terminates existing un-attributed component
        if !currentSubstring.isEmpty {
            result.append((tagName: nil, substring: currentSubstring))
        }

        return result
    }
}

// MARK: - String Components Separated by Tags Errors
/*private*/ struct StringComponentsSeparatedByTagsError: VCoreError, Equatable {
    // MARK: Properties
    private let code: Code

    // MARK: Initializers
    init(_ code: Code) {
        self.code = code
    }

    // MARK: Code
    enum Code: Int, Equatable {
        case nestedTagsNotSupported

        case invalidOpeningTag
        case slashFoundInOpeningTag
        case openingTagNameNotFound

        case invalidClosingTag
        case closingTagSlashNotFound
        case closingTagNameNotFound

        case unknownErrorOccurred
    }

    // MARK: VCore Error
    var vCoreErrorCode: Int { code.rawValue }

    var vCoreErrorDescription: String {
        switch code {
        case .nestedTagsNotSupported: "Nested tags not supported"

        case .invalidOpeningTag: "Invalid opening tag"
        case .slashFoundInOpeningTag: "Slash found in opening tag"
        case .openingTagNameNotFound: "Opening tag name not found"

        case .invalidClosingTag: "Invalid closing tag"
        case .closingTagSlashNotFound: "Closing tag slash not found"
        case .closingTagNameNotFound: "Closing tag name not found"

        case .unknownErrorOccurred: "Unknown error occurred"
        }
    }

    // MARK: Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    Text(
        AttributedString(
            defaultingIfError: "Lorem <b>ipsum dolor</b> sit amet, <c>consectetur adipiscing</c> elit",
            attributeContainers: [
                "b": {
                    var container: AttributeContainer = .init()
                    container.foregroundColor = .red
                    container.font = .title.weight(.ultraLight)
                    return container
                }(),
                "c": {
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
