//
//  testViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit
import GoogleGenerativeAI
import CoreData

class AIViewController: UIViewController {

//  let aimodel = GenerativeModel(name: "gemini-1.5-flash", apiKey: geminiApiKey)
  var location = "서울"
  var currentWeather = "맑음"
  var aiView: AIView!
  var selected = ""
  var categories: Categories?
  
  override func loadView() {
    aiView = AIView(frame: UIScreen.main.bounds)
    self.view = aiView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    aiView.button1.addTarget(self, action: #selector(button1tapped), for: .touchUpInside)
    aiView.button2.addTarget(self, action: #selector(button2tapped), for: .touchUpInside)
    aiView.button3.addTarget(self, action: #selector(button3tapped), for: .touchUpInside)
  }
  
  func answerDecoding(_ data: String, _ selected: String) {
    guard let jsonData = data.data(using: .utf8) else {
      fatalError()
    }
    do {
      let categories = try JSONDecoder().decode(Categories.self, from: jsonData)
      self.categories = categories
      aiSelectOptions(selected)
    } catch {
    }
  }
  func aiSelectOptions(_ selected: String) {
    guard let selectedCategory = categories?[selected] else { return }
    aiView.button1.setTitle("\(selectedCategory[0].name)", for: .normal)
    aiView.button2.setTitle("\(selectedCategory[1].name)", for: .normal)
    aiView.button3.setTitle("\(selectedCategory[2].name)", for: .normal)
  }
  func aiDescription(_ index: Int) {
    switch selected {
    case "culture":
      if let message = self.categories?.culture[index].description {
        aiView.textView.text += "\n\(message)"
      }
    case "shopping":
      if let message = self.categories?.shopping[index].description {
        aiView.textView.text += "\n\(message)"
      }
    case "food":
      if let message = self.categories?.food[index].description {
        aiView.textView.text += "\n\(message)"
      }
    default:
      print("")
    }
  }
  func buttonTapped(_ num: Int) {
    if selected.isEmpty {
      selected = "culture"
      aiView.loadingView.isLoading = true
      Task {
        await openAIAnswer()
        aiView.textView.text += "\n어떤 것에 흥미가 있으신가요?"
        aiView?.loadingView.isLoading = false
      }
    } else {
      aiDescription(num)
      hideButton()
    }
  }
  
  @objc func button1tapped() {
    buttonTapped(0)
  }
  @objc func button2tapped() {
    buttonTapped(1)
  }
  @objc func button3tapped() {
    buttonTapped(2)
  }
  
  func hideButton() {
    aiView.buttonStackView.isHidden = true
  }
  func openAIAnswer() async {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY") as? String else { return }
    let aimodel = GenerativeModel(name: "gemini-1.5-flash", apiKey: apiKey)
    let prompt = "여기는 \(location)이고 날씨는 \(currentWeather)인데 할 것 추천해줘. 그 내용들을 json 형식으로 분류해서 만들어줘 답변에는 코드만 있어야되. culture, shopping, food 세가지 분류 안에, name으로 세가지 선택지가 들어가 있고 그 선택지 내부에 description에 자세한 내용을 ~를 해보는건 어떠신가요? 라는 물음 형태로 넣어줘"
    do {
      let response = try await aimodel.generateContent(prompt)
      if var text = response.text {
        text.removeFirst(7)
        text.removeLast(3)
        answerDecoding(text, selected)
      }
    } catch {
    }
  }
}
