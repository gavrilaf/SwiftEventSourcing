import Foundation

public class AccountManager {
    
    public init(eventStorage: EventStorage) {
        self.storage = eventStorage
    }
    
    /**
     * Create new account with zero balance
     */
    public func openAccount() -> Account {
        let account = AccountImpl(id: UUID().uuidString, history: [])
        accounts[account.id] = account
        
        return account
    }
    
    public func getAccount(id: String) -> Account? {
        return accounts[id]
    }
    
    public func handle(command: Command, forAccount id: String) -> CommandResult {
        guard let account = accounts[id] else {
            return CommandResult(error: .notFound)
        }
        
        return account.handle(command: command).flatMap { (event) -> CommandResult in
            storage.save(event: event, forAccount: id)
            return CommandResult(value: event)
        }
    }
    
    private var accounts = [String : AccountImpl]()
    private var storage: EventStorage
}


