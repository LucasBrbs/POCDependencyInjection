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

public class CoursesViewController: UIViewController {

    let dataFetchable: DataFetchable

    public init(dataFetchable: DataFetchable){
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataFetchable.fetchCourseNames { courses in
            print(courses)
        }
    }


}
