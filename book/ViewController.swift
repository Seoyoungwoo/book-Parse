//
//  ViewController.swift
//  book
//
//  Created by D7703_24 on 2018. 10. 8..
//  Copyright © 2018년 D7703_24. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var myBookData = [BookData]()
    
    var bTitle = ""
    var bAuthor = ""
    
    var current = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        // Fruit.xml 화일을 가져 오기
        // optional binding nil check
        if let path = Bundle.main.url(forResource: "book", withExtension: "xml") {
            // 파싱 시작
            if let myParser = XMLParser(contentsOf: path) {
                // delegate를 ViewController와 연결
                myParser.delegate = self
                
                if myParser.parse() {
                    print("성공")
                    //print(myBookData[0].title)
                    //                    print(myFruitData[0].color)
                    //                    print(myFruitData[0].cost)
                    
                    for i in 0 ..< myBookData.count {
                        print(myBookData[i].title)
                    }
                } else {
                    print("실패")
                }
                
            } else {
                print("오류 발생")
            }
            
        } else {
            print("xml file not found")
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        current = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            switch current {
            case "title" : bTitle = data
            case "author" : bAuthor = data
            default : break
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let Item = BookData()
            Item.title = bTitle
            Item.author = bAuthor
            myBookData.append(Item)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBookData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        cell.textLabel?.text = myBookData[indexPath.row].title
        cell.detailTextLabel?.text = myBookData[indexPath.row].author
        return cell
    }
}



