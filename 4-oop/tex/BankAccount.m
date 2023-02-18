% This class creates a bank account object that can be used to manage a bank
% account. The object has a 'balance' property that represents the current
% balance of the account. The object also has methods for depositing and
% withdrawing money from the account, as well as getting the current balance.
classdef BankAccount
    
    % This section defines the class properties, which are variables
    % that belong to each instance of the class.
    properties (Access = private)
        
        % This line defines the 'balance' property, which is a 1x1 double
        % precision floating-point number that must be non-negative.
        balance (1,1) double {mustBeNonnegative}
    end
    
    % This section defines the class methods, which are functions that belong
    % to each instance of the class and can operate on its properties.
    methods
        
        % This method is the constructor, which creates a new instance of
        % the class and initializes its properties.
        %
        % Usage: account = BankAccount(initial_balance)
        %
        % Inputs:
        %   initial_balance - The initial balance of the account (double).
        %
        % Outputs:
        %   account - The newly created BankAccount object.
        function obj = BankAccount(initial_balance)
            
            % This line assigns the initial balance to the 'balance' property
            % of the new instance of the class.
            obj.balance = initial_balance;
        end
        
        % This method is used to get the current balance of the bank account.
        %
        % Usage: balance = account.balance
        %
        % Inputs:
        %   None.
        %
        % Outputs:
        %   balance - The current balance of the account (double).
        function balance = get.balance(obj)
            % This line returns the 'balance' property of the object.
            balance = obj.balance;
        end
        
        % This method is used to set the balance of the bank account.
        %
        % Usage: account.balance = new_balance
        %
        % Inputs:
        %   new_balance - The new balance of the account (double).
        %
        % Outputs:
        %   account - The modified BankAccount object.
        function obj = set.balance(obj, balance)
             % This line sets the 'balance' property of the object to the
             % value passed as an argument to the method.
             obj.balance = balance;
        end
        
        % This method is used to add money to the bank account.
        %
        % Usage: account = account.deposit(amount)
        %
        % Inputs:
        %   amount - The amount to be deposited (double).
        %
        % Outputs:
        %   account - The modified BankAccount object.
        %
        % Throws an error if the amount is negative.
        function obj = deposit(obj, amount)
            % This line checks if the amount is negative and throws an error
            % if it is.
            if amount < 0
                error('BankAccount:deposit:negativeDeposit', ...
                      'Deposit amount cannot be negative.')
            end
            % This line adds the amount to the 'balance' property of the object.
            obj.balance = obj.balance + amount;
        end
        
        % This method is used to withdraw money from the bank account.
        %
        % Usage: account = account.withdraw(amount)
        %
        % Inputs:
        %   amount - The amount to be withdrawn (double).
        %
        % Outputs:
        %   account - The modified BankAccount object.
        %
        % Throws an error if the amount is negative or if the
        % balance is insufficient for the withdrawal.
        function obj = withdraw(obj, amount)
            % This line checks if the amount is negative and throws an error
            % if it is.
            if amount < 0
                error('BankAccount:withdraw:negativeWithdrawal', ...
                      'Withdrawal amount cannot be negative.')
            end
            % This line checks if the 'balance' property of the object is
            % greater than or equal to the amount to be withdrawn and throws
            % an error if it is not.
            if obj.balance < amount
                error('BankAccount:withdraw:insufficientFunds', ...
                      'Insufficient funds.')
            end
            % This line subtracts the amount from the 'balance' property of the
            % object.
            obj.balance = obj.balance - amount;
        end
    end
end

        
