//
//  ViewController.swift
//  truthordare
//
//  Created by Alexander Telegin on 20.08.2023.
//

import UIKit
import XRPLSwift

class ViewController: UIViewController {

    private var client: XrplClient!

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupClient()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let vaultAccount = DataStore.shared.geValue("VaultAddressKey"),
                  vaultAccount != "",
                  let signerAddress = DataStore.shared.geValue("SignerAddress"),
                  signerAddress != "",
                  let privateKey = DataStore.shared.geValue("SignerPrivateKey"),
                  privateKey != "" else {
                return
            }
            let signerWallet = Wallet(
                publicKey: signerAddress,
                privateKey: privateKey
            )
            let json = [
                "TransactionType": "Payment",
                "Account": signerAddress,
                "Destination": vaultAccount,
                "Amount": "1",
                "Fee": "1000000",
                "NetworkID": "21338",


                "InvoiceID": "93188273D406F4D047990C4A741A96DC838FDB627126C1CD095846634CE0CC18",
            ] as [String: AnyObject]
            let tx: Transaction = try! Transaction(json)!
            Task {
                await self.submitTransaction(
                    client: self.client,
                    transaction: tx,
                    wallet: signerWallet
                )
            }
        }
    }

    func setupClient() {
        let url: String = "wss://hooks-testnet-v3.xrpl-labs.com:51234"
        client = try! XrplClient(server: url)
    }

    public func ledgerAccept(client: XrplClient) async {
        let request = [ "command": "ledger_accept" ] as [String: AnyObject]
        _ = try! await client.connection.request(request: BaseRequest(request))
    }

    func submitTransaction(
        client: XrplClient,
        transaction: Transaction,
        wallet: Wallet
    ) async {
        // Accept any un-validated changes.
        await ledgerAccept(client: client)

        // sign/submit the transaction
        let response = try! await client.submit(
            transaction: transaction,
            opts: SubmitOptions(
                autofill: false,
                failHard: false,
                wallet: wallet
            )
        ).get() as! BaseResponse<SubmitResponse>

        await ledgerAccept(client: client)
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Vault Settings"

        // Add the main stack view to the view
        view.addSubview(stackView)

        // Set up constraints for the main stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

}

// Unsued for now, needed for future debugging
extension ViewController: ConnectionDelegate {
    func error(code: Int, message: Any, data: Data) {
        print("error(code: Int, message: Any, data: Data)")
        dump(message)
    }

    func connected() {
        print("connected()")
    }

    func disconnected(code: Int) {
        print("disconnected(code: Int)")
        dump(code)
    }

    func ledgerClosed(ledger: Any) {
        print("ledgerClosed(ledger: Any)")
        dump(ledger)
    }

    func transaction(tx: Any) {
        print("transaction(tx: Any)")
        dump(tx)
    }

    func validationReceived(validation: Any) {
        print("validationReceived(validation: Any)")
        dump(validation)
    }

    func manifestReceived(manifest: Any) {
        print("manifestReceived(manifest: Any)")
        dump(manifest)
    }

    func peerStatusChange(status: Any) {
        print("peerStatusChange(status: Any)")
        dump(status)
    }

    func consensusPhase(consensus: Any) {
        print("consensusPhase(consensus: Any)")
        dump(consensus)
    }

    func pathFind(path: Any) {
        print("pathFind(path: Any)")
        dump(path)
    }
}
