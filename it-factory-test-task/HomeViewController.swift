//
//  MainViewController.swift
//  it-factory-test-task
//
//  Created by Gleb Glushok on 03.10.2022.

import UIKit

class HomeViewController: UIViewController {
    
    var articlesModel: ArticlesModel?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.initTableViewData()
        }
    }
    
    func initTableViewData() {
        parseJSON { [weak self] articlesModel in
            self?.articlesModel = articlesModel
            self?.homeFeedTable.reloadData()
        }
    }
    
    func parseJSON(completion: @escaping(_ articlesModel: ArticlesModel?) -> Void ) {
        guard let path = Bundle.main.path(forResource: "jsonviewer", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            articlesModel = try JSONDecoder().decode(ArticlesModel.self, from: jsonData)
            completion(articlesModel)
            if let articles = articlesModel {
                print(articles)
            } else {
                print("Failed to parse")
            }
            return
        } catch {
            print("Error: \(error)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articlesModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return articlesModel?.sections[section].header
    }
}

