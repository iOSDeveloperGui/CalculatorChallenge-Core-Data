//
//  SecondViewController.swift
//  Calculator
//
//  Created by iOS Developer on 04/12/24.
//

import UIKit
import CoreData

class SecondViewController: UIViewController{
    
    //MARK: - ARRAY (Core data)
    var calculations: [NSManagedObject] = []
    
    //MARK: - UIComponents
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "calculationCell")
        return tableView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        addSubView()
        setupConstraints()
        fetchCalculationsAndUpdateTable()
        setupUITable()
    }
    
    //MARK: - AddSubViewMethod
    private func addSubView(){
        view.addSubview(tableView)
    }
    
    //MARK: - SetupConstraintsMethod
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - FetchCalculationsMethod(CoreData)
    private func fetchCalculations() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fecthRequest = NSFetchRequest<NSManagedObject>(entityName: "Operation")
        
        do{
            let calculations = try managedContext.fetch(fecthRequest)
            return calculations
        } catch let error as NSError{
            print("Could not fecth: \(error), \(error.userInfo)")
            return nil
        }
    }
    //MARK: - fetchCalculationsAndUpdateTable(reload)
    private func fetchCalculationsAndUpdateTable(){
        guard let fetched = fetchCalculations() else{
            return
        }
        tableView.reloadData()
        calculations = fetched
    }
    
    //MARK: - SetupUITable
    private func setupUITable(){
        title = "Calculation History"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)
        ]
        navigationController?.navigationBar.barTintColor = .bg
        navigationController?.navigationBar.tintColor = .white
    }
}

//MARK: - Extension
extension SecondViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calculations.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calculationCell", for: indexPath)
        
        let calculation = calculations[indexPath.row]
        let valueA = calculation.value(forKey: "valueA") as? Double ?? 0
        let valueB = calculation.value(forKey: "valueB") as? Double ?? 0
        let operation = calculation.value(forKey: "operation") as? String ?? ""
        let date = calculation.value(forKey: "date") as? Date
        let result = calculation.value(forKey: "result") as? Double ?? 0
        
        let operationSymbols: [String:String] = [
            "Addition" : "+",
            "Subtraction": "-",
            "Multiplication": "*",
            "Division": "/"
        ]
        
        let operationSymbol = operationSymbols[operation] ?? operation
        let sequentialID = indexPath.row
        
        // Formating the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let formattedDate = date != nil ? dateFormatter.string(from: date!) : "Unknow ID"
        
        //Showing the info
        cell.textLabel?.text = """
        ID: \(sequentialID)
        ValueA: \(valueA) \(operationSymbol) ValueB: \(valueB) = \(result)
        Date: \(formattedDate)
        """
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
}


