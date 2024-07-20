//
//  testViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit
import GoogleGenerativeAI
import CoreData

class AIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
  var location: String = ""
  var currentWeather: String = ""
  var selected: String = ""
  var aiView: AIView!
  var categories: Categories?
  var aimessages: [String] = []
  var weatherImageName: String = ""
  
  override func loadView() {
    aiView = AIView(frame: UIScreen.main.bounds)
    self.view = aiView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupButtonActions()
    setUpTableView()
    getCurrentData()
  }
  func setupButtonActions() {
    aiView.button1.addTarget(self, action: #selector(handleButton1Tap), for: .touchUpInside)
    aiView.button2.addTarget(self, action: #selector(handleButton2Tap), for: .touchUpInside)
    aiView.button3.addTarget(self, action: #selector(handleButton3Tap), for: .touchUpInside)
  }
  func setUpTableView() {
    aiView.aiMessageTableView.dataSource = self
    aiView.aiMessageTableView.delegate = self
    aiView.aiMessageTableView.register(AIMessageTableViewCell.self, forCellReuseIdentifier: "AIMessageTableViewCell")
  }
  func getCurrentData() {
    NetworkManager.shared.getCurrentData { weatherData in
      if let weatherData = weatherData {
        DispatchQueue.main.async {
          self.currentWeather = weatherData.weather.first!.description
          self.location = weatherData.name
          self.aiView.longlong2.image = UIImage(named: weatherData.weather.first!.main)
          self.weatherImageName = weatherData.weather.first!.main
        }
      }
    }
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
    var message: String? = nil
    switch selected {
    case "culture":
      message = self.categories?.culture[index].description
    case "shopping":
      message = self.categories?.shopping[index].description
    case "food":
      message = self.categories?.food[index].description
    default:
      print("Unknown category")
    }
    if let message = message {
      aimessages.append(message)
      aiView.aiMessageTableView.reloadData()
    }
  }
  func buttonTapped(_ num: Int) {
    if selected.isEmpty {
      selected = "culture"
      aiView.loadingView.isLoading = true
      Task {
        await openAIAnswer()
        aimessages.append("어떤 것에 흥미가 있으신가요?")
        aiView.aiMessageTableView.reloadData()
        aiView?.loadingView.isLoading = false
      }
    } else {
      aiDescription(num)
      hideButton()
    }
  }
  
  @objc func handleButton1Tap() {
    buttonTapped(0)
  }
  @objc func handleButton2Tap() {
    buttonTapped(1)
  }
  @objc func handleButton3Tap() {
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
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    aimessages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "AIMessageTableViewCell", for: indexPath) as? AIMessageTableViewCell else {
      return UITableViewCell()
    }
    let aimessage = aimessages[indexPath.row]
    cell.configureCell(aimessage: aimessage, imageName: weatherImageName)
    
    return cell
  }
  

}
