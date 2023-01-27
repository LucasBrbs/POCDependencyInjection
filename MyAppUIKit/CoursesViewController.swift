//
//  CoursesViewController.swift
//  MyAppUIKit
//
//  Created by Lucas Barbosa de Oliveira on 25/01/23.
//

import UIKit

public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping (String) -> Void)
}

struct Fact {
    let fact: String
}

public class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let dataFetchable: DataFetchable

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    public init(dataFetchable: DataFetchable){
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var facts: [Fact] = []

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        dataFetchable.fetchCourseNames { [weak self] facts in
            self?.facts = facts.map{Fact(fact: $0)}
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = facts[indexPath.row].fact
        return cell
    }
}
