//
//  ResultViewController.swift
//  Calculator
//
//  Created by iOS Developer on 04/12/24.
//

import UIKit
import CoreData

class ResultViewController: UIViewController {
    
    //MARK: - Variable
    var result: Double?
    
    //MARK: - UIComponents
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The result is: "
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var resultValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .white
        label.shadowColor = .button
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Do you want to calculate something else?"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Return to Calculator", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(returnToCalculator), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .bg
        addSubView()
        setupConstraints()
        setupNavigation()
        resultFetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async{
            self.showMessage("Successfully stored calculation")
        }
    }
    
    //MARK: - AddSubViewMethod
    private func addSubView(){
        view.addSubview(resultLabel)
        view.addSubview(resultValueLabel)
        view.addSubview(promptLabel)
        view.addSubview(returnButton)
    }
    
    //MARK: - SetupConstraintsMethod
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            //Setting ResultlabelConstaint
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 182),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            resultValueLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            resultValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            //Setting PromptLabelConstraint
            promptLabel.topAnchor.constraint(equalTo: resultValueLabel.bottomAnchor, constant: 20),
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            //Setting returnButtonConstraint
            returnButton.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 30),
            returnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            returnButton.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    //MARK: - SetupNavigation
    private func setupNavigation(){
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //MARK: - ButtonActions
    @objc private func returnToCalculator(){
        navigationController?.popViewController(animated: true)
    }
    
    private func resultFetch(){
        guard let result = result else{
            resultValueLabel.text = "0"
            return
        }
        resultValueLabel.text = "\(result)"
    }
    
    //MARK: - ShowAlertMethod
    private func showAlert(title: String, message: String, isError: Bool = false){
        let alert = UIAlertController(
            title: isError ? "Error" : "Success",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func showMessage(_ message: String){
        showAlert(title: "Success", message: message)
    }
    


}

#Preview{
    ResultViewController()
}
