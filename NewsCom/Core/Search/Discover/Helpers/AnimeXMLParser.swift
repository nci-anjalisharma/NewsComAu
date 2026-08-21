//
//  AnimeXMLParser.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/08/26.
//
import Foundation

final class AnimeXMLParser: NSObject {

    private var currentElement = ""
    private var animeID = ""
    private var title = ""
    private var type: String?
    private var imageURL: String?

    private var genres: [String] = []

    private var episodes: Int?
    private var rating: Double?

    private var currentInfoType = ""
    private var currentValue = ""

    private var completion: ((Result<Anime, Error>) -> Void)?
    
    private var plotSummary: String?

    func parse(data: Data, completion: @escaping (Result<Anime, Error>) -> Void) {

        self.completion = completion

        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
}

extension AnimeXMLParser: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String,
        namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        currentElement = elementName

        if elementName == "anime" {

            animeID = attributeDict["id"] ?? ""

            if let typeValue = attributeDict["type"] {
                type = typeValue
            }

        } else if elementName == "info" {

            currentInfoType = attributeDict["type"] ?? ""
            currentValue = ""

        } else if elementName == "img" {

            imageURL = attributeDict["src"]

        } else if elementName == "rating" {

            if let score = attributeDict["weighted_score"] {
                rating = Double(score)
            }
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {

        currentValue += string
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        let value = currentValue.trimmingCharacters(in: .whitespacesAndNewlines)

        if elementName == "info" {

            switch currentInfoType {

            case "Main title":
                title = value

            case "Type":
                type = value

            case "Genres":
                genres.append(value)

            case "Number of episodes":
                episodes = Int(value)

            case "Average rating":
                rating = Double(value)
                
            case "Plot Summary":
                plotSummary = value

            default:
                break
            }
            
            currentInfoType = ""
            currentValue = ""
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {

        let anime = Anime(id: animeID, title: title, type: type, imageURL: imageURL, genres: genres, episodes: episodes, rating: rating, plotSummary: plotSummary)

        completion?(.success(anime))
        completion = nil
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {

        completion?(.failure(parseError))
        completion = nil
    }
}
