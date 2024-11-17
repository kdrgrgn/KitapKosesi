import Foundation

struct BookListModel: Decodable {
    let kind: String?
    let totalItems: Int?
    let items: [BookModel]?
}

struct BookModel: Decodable {
    let kind, id, etag: String?
    let selfLink: String?
    let volumeInfo: VolumeInfo?
    let saleInfo: SaleInfo?
    let accessInfo: AccessInfo?
}

struct AccessInfo: Decodable {
    let country, viewability: String?
    let embeddable, publicDomain: Bool?
    let textToSpeechPermission: String?
    let epub, pdf: Epub?
    let webReaderLink: String?
    let accessViewStatus: String?
    let quoteSharingAllowed: Bool?
}

struct Epub: Decodable {
    let isAvailable: Bool?
}

struct SaleInfo: Decodable {
    let country, saleability: String?
    let isEbook: Bool?
}

struct VolumeInfo: Decodable {
    let title: String?
    let authors: [String]?
    let publisher, publishedDate, volumeInfoDescription: String?
    let industryIdentifiers: [IndustryIdentifier]?
    let readingModes: ReadingModes?
    let pageCount, printedPageCount: Int?
    let dimensions: Dimensions?
    let printType: String?
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummary?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink: String?
    let infoLink, canonicalVolumeLink: String?
}

struct Dimensions: Decodable {
    let height, width, thickness: String?
}

struct ImageLinks: Decodable {
    let smallThumbnail, thumbnail, small, medium: String?
    let large, extraLarge: String?
}

struct IndustryIdentifier: Decodable {
    let type, identifier: String?
}

struct PanelizationSummary: Decodable {
    let containsEpubBubbles, containsImageBubbles: Bool?
}

struct ReadingModes: Decodable {
    let text, image: Bool?
}
