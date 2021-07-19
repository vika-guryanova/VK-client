//
//  LoginViewController.swift
//  VK-client
//
//  Created by Victoria Guryanova on 05.07.2021.
//

import UIKit

final class LoginViewController: UIViewController {

	@IBOutlet private weak var scrollView: UIScrollView!
	@IBOutlet private weak var titleImageView: UIImageView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet private weak var loginTextField: UITextField!
	@IBOutlet weak var passwordLabel: UILabel!
	@IBOutlet private weak var passwordTextField: UITextField!
	@IBOutlet private weak var loginButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		scrollView.addGestureRecognizer(tapGesture)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Подписываемся на два уведомления: одно приходит при появлении клавиатуры
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
		// Второе - когда клавиатура исчезает
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		// Отписываемся от уведомлений о клавиатуре
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@IBAction func loginButtonPressed(_ sender: UIButton) {
		// Получаем текст логина
		guard
			let login = loginTextField.text,
			let password = passwordTextField.text
		else {
			print("Login or password is equal to nil")
			return
		}
		
		// Проверяем, верны ли логин и пароль
		if login == "1" && password == "1" {
			print("Успешная авторизация")
		} else {
			print("Неуспешная авторизация")
		}
	}
	
	// Клавиатура появляется
	@objc func keyboardWasShown(notification: Notification) {
		
		// Получаем размер клавиатуры
		let info = notification.userInfo! as NSDictionary
		let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
		let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
		
		// Добавляем отступ внизу UIScrollView, равный размеру клавитуры
		self.scrollView?.contentInset = contentInsets
		scrollView?.scrollIndicatorInsets = contentInsets
	}
	
	// Клавиатура исчезает
	@objc func  keyboardWillBeHidden(notification: Notification) {
		
		// Устанавливаем отступ внизу UIScrollView, равный 0
		let contentInsets = UIEdgeInsets.zero
		scrollView?.contentInset = contentInsets
		scrollView?.scrollIndicatorInsets = contentInsets
	}
	
	@objc private func hideKeyboard() {
		self.scrollView?.endEditing(true)
	}
}
