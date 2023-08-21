import { XrplClient } from "https://esm.sh/xrpl-client?bundle";

const lib = require("xrpl-accountlib");
const bin = require("ripple-binary-codec");
const keypairs = require("ripple-keypairs");

/**
 * @input {Account} vault_account Vault Account
 * @input {Account.secret} proposer_secret Proposer Account
 * @input {String} proposer_amount Proposer Amount
 * @input {Account} receiver_account Receiver Account
 */

const { vault_account, proposer_secret, proposer_amount, receiver_account } = process.env

const proposer_keypair = lib.derive.familySeed(proposer_secret);
const proposer_account = keypairs.deriveAddress(proposer_keypair.keypair.publicKey);

const client = new XrplClient('wss://hooks-testnet-v3.xrpl-labs.com');

const main = async () => {
    console.log('vault_account', vault_account);
    const proposed_tx = {
        TransactionType: 'Payment',
        Account: vault_account,
        Amount: proposer_amount, //'29364879',//'42',//'100000000',
        Destination: receiver_account,
        DestinationTag: '42',
        LastLedgerSequence: "4000000000", 
        Fee: '0',
        Sequence: 0,
        NetworkID: "21338"
    };

    const inner_tx = bin.encode(proposed_tx);

    const { account_data } = await client.send({ command: 'account_info', 'account': proposer_account });
    if (!account_data) {
        console.log('Proposer account not found.');
        client.close();
        return;
    }

    const tx = {
        TransactionType: 'Payment',
        Account: proposer_account,
        Amount: '1',
        Destination: vault_account,
        Fee: '12000000',
        Memos: [
            {
                Memo: {
                    MemoData: inner_tx,
                    MemoFormat: "unsigned/payload+1",
                    MemoType: "vault/proposed"
                }
            }
        ],
        Sequence: account_data.Sequence,
        NetworkID: "21338"
    };

    hexlify_memos(tx);

    const {signedTransaction} = lib.sign(tx, proposer_keypair);
    const submit = await client.send({ command: 'submit', 'tx_blob': signedTransaction });
    console.log(submit);

    console.log('Shutting down...');
    client.close();
};

function hexlify_memos(x)
{
    if (!("Memos" in x))
        return;

    for (let y = 0; y < x["Memos"].length; ++y)
    {
        let Memo = x["Memos"][y]["Memo"];
        let Fields = ["MemoFormat", "MemoType", "MemoData"];
        for (let z = 0; z < Fields.length; ++z)
        {
            if (Fields[z] in Memo)
            {
                let u = Memo[Fields[z]].toUpperCase()
                if (u.match(/^[0-9A-F]+$/))
                {
                    Memo[Fields[z]] = u;
                    continue;
                }

		let v = Memo[Fields[z]], q = "";
		for (let i = 0; i < v.length; ++i)
		{
		    q += Number(v.charCodeAt(i)).toString(16).padStart(2, '0');
		}
		
                Memo[Fields[z]] = q.toUpperCase();
            }
        }
    }
}

main()