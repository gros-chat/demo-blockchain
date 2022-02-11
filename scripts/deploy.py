from brownie import BillOfLadding2, network, accounts, Contract
import time, json

privateKey = "0b619c26f61348d2968eb343b06ef2d2d619d0572f6b0b34cf7eaeb89f453f05"
privateKeyRopsten = "b5ebd45fef43239d0894ce45fff63a7255068d4bbbc539d3b591dd7a9257a4a0"


def deploy():
    account = accounts.add(privateKeyRopsten)
    # account = accounts[0]
    BoLCI = BillOfLadding2.deploy({"from": account})
    #save the address
    data ={'BoLCI address':BoLCI.address}
    with open('address.json', 'w') as json_file:
        json.dump(data, json_file)
    # prevent the connection from closing to early and crashing the program
    time.sleep(1)


def fundContract(leAmount):
    # account = accounts[0]
    account = accounts.add(privateKeyRopsten)
    # Bill = BillOfLadding2.at("0xF4bb75a8C47553a01f1769acCCb527788069667C")
    with open('address.json', 'r') as f:
        data = json.load(f)

    laAddress = data['BoLCI address']
    print('la adresse '+ laAddress)
    Bill = BillOfLadding2.at(laAddress)
    tx = Bill.fundPrice({"from": account, "value": leAmount})
    time.sleep(1)


def main():
    #deploy()
    fundContract(2000000)

