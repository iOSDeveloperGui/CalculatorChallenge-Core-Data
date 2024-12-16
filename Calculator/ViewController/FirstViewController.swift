//
//  FirstViewController.swift
//  Calculator
//
//  Created by iOS Developer on 03/12/24.
//

import UIKit
import CoreData

class FirstViewController: UIViewController{
    
    //MARK: - Variables
    private var selectedOperation: String?
    
    //MARK: - UIComponents
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please enter the value A and the value B"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var valueALabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Value A"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var valueBLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Value B"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var value1TextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "value A"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var value2TextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "value B"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var optionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You must choose a mathematical operation "
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .light)
        return label
    }()
    
    private lazy var operationButtons: [UIButton] = {
        let operations = ["Addition", "Subtraction", "Multiplication", "Division"]
        return operations.map {operation in
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(operation, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 12
            button.tag = operations.firstIndex(of: operation) ?? 0
            button.addTarget(self, action: #selector(setSelectedOperatioMethod), for: .touchUpInside)
            return button
        }
    }()
    
    private lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "buttonColor")
        button.setTitle("Calcule", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(calculationAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var showTheRecords: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Show the records", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(showRecords), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        addSubView()
        setupConstraints()
        setupNavigation()
        calculationAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //the "validating()" method doesn't interfere with UIKit’s layout.
        DispatchQueue.main.async{
            self.validating()
        }
    }
    
    //MARK: - AddSubViewFunction
    private func addSubView(){
        view.addSubview(mainLabel)
        view.addSubview(valueALabel)
        view.addSubview(valueBLabel)
        view.addSubview(value1TextField)
        view.addSubview(value2TextField)
        view.addSubview(optionLabel)
        operationButtons.forEach {view.addSubview($0)}
        view.addSubview(calculateButton)
        view.addSubview(showTheRecords)
    }
    
    //MARK: - SetupConstraintsFunction
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            // Setting MainLabel Constaint
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            // Setting ValueALabel Constaint
            valueALabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            valueALabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            
            // Setting Value1TextField Constaint
            value1TextField.topAnchor.constraint(equalTo: valueALabel.bottomAnchor, constant: 8),
            value1TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            value1TextField.widthAnchor.constraint(equalToConstant: 100),
            value1TextField.heightAnchor.constraint(equalToConstant: 100),
            
            // Setting ValueBLabel Constaint
            valueBLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            valueBLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            
            // Setting Value2TextField Constaint
            value2TextField.topAnchor.constraint(equalTo: valueBLabel.bottomAnchor, constant: 8),
            value2TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            value2TextField.widthAnchor.constraint(equalToConstant: 100),
            value2TextField.heightAnchor.constraint(equalToConstant: 100),
            
            //Setting OptionLabel Constaint
            optionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            optionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            //Setting OperationButtons Constaint
            operationButtons[0].topAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: 40),
            operationButtons[0].centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            operationButtons[1].topAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: 40),
            operationButtons[1].centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            operationButtons[2].topAnchor.constraint(equalTo: operationButtons[0].bottomAnchor, constant: 20),
            operationButtons[2].centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            operationButtons[3].topAnchor.constraint(equalTo: operationButtons[1].bottomAnchor, constant: 20),
            operationButtons[3].centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            
            // Adjusting buttons width
            operationButtons[0].widthAnchor.constraint(equalToConstant: 136),
            operationButtons[1].widthAnchor.constraint(equalToConstant: 136),
            operationButtons[2].widthAnchor.constraint(equalToConstant: 136),
            operationButtons[3].widthAnchor.constraint(equalToConstant: 136),
            
            // Setting CalculateButton Constaint
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.topAnchor.constraint(equalTo: showTheRecords.topAnchor, constant: -60),
            calculateButton.widthAnchor.constraint(equalToConstant: 300),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Setting RecordsButton Constaint
            showTheRecords.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showTheRecords.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            showTheRecords.widthAnchor.constraint(equalToConstant: 300),
            showTheRecords.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    //MARK: - SetupNavigationMethod
    private func setupNavigation(){
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //MARK: - SetSelectedOperationMethod
    @objc private func setSelectedOperatioMethod(tap: UIButton){
        selectedOperation = tap.title(for: .normal)
        
        tap.isSelected = true
        tap.backgroundColor = UIColor(named: "buttonColor")
        operationButtons.forEach {button in
            if button != tap{
                button.isSelected = false
                button.backgroundColor = .white
            }
        }
    }
    
    //MARK: - ShowRecordsMethod
    @objc private func showRecords(){
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    //MARK: - CalculationActionMethod
    @objc private func calculationAction(){
        
        guard let valueAText = value1TextField.text,
              let valueBText = value2TextField.text,
              let operation = selectedOperation
        else{
            return
        }
        
        // If an user input a invalid character
        guard let valueA = Double(valueAText),
              let valueB = Double(valueBText)
        else{
            showError("Please enter valid numbers.")
            return
        }
        
        // operations
        let result: Double
        switch operation {
        case "Addition":
            result = valueA + valueB
        case "Subtraction":
            result = valueA - valueB
        case "Multiplication":
            result = valueA * valueB
        case "Division":
            guard valueB != 0 else{
                showError("Cannot divide by zero.")
                return
            }
            result = valueA / valueB
        default:
            return
        }
        
        saveCalculation(valueA: valueA, valueB: valueB, operation: operation, result: result)
        value1TextField.text = ""
        value2TextField.text = ""
        selectedOperation = nil
        
        let fetchLastestResult = fetchLatestCalculation()
        let resultVC = ResultViewController()
        resultVC.result = fetchLastestResult
        navigationController?.pushViewController(resultVC, animated: false)
    }
    
    //MARK: - FetchLatestCalculationMethod
    private func fetchLatestCalculation() -> Double?{
        let context = UIApplication.shared.context
        let fetchRequest: NSFetchRequest<Operation> = Operation.fetchRequest()
    
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do{
            let calculations = try context.fetch(fetchRequest)
            return calculations.first?.result
        } catch {
            print("Failed to fetch calculations: \(error.localizedDescription)")
            return nil
        }
    }

    //MARK: - SetupCoreData
    private func saveCalculation(valueA: Double, valueB: Double, operation: String, result: Double){
        guard UIApplication.shared.delegate is AppDelegate else { return }
        
        let context = UIApplication.shared.context
        let calculation = Operation(context: context)
        
        calculation.id = UUID()
        calculation.valueA = valueA
        calculation.valueB = valueB
        calculation.operation = operation
        calculation.result = result
        calculation.date = Date()
        
        do{
            try context.save()
            print("Calculation saved successfully")
        } catch{
            print("Error saving calculation: \(error.localizedDescription)")
        }
    }
    
    //MARK: - ShowError&ShowMessageMethods
    private func showAlert(title: String, message: String, isError: Bool = false){
        let alert = UIAlertController(
            title: isError ? "Attention" : "Success",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func showError(_ message: String){
        showAlert(title: "Attention", message: message, isError: true)
    }
    
    //MARK: - Warning
    
    private func validating(){
            showError("Both fields must be filled and don't forget to get a math operation. Thanks for using it! :)")
    }
}

    //MARK: - Extension (core data configuration)
extension UIApplication{
    var persistentContainer: NSPersistentContainer{
        guard let delegate = self.delegate as? AppDelegate else{
            fatalError("Unable to find AppDelegate")
        }
        return delegate.persistentContainer
    }
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
}
#Preview{
    FirstViewController()
}
