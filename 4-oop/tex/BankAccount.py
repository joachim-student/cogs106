class BankAccount:
    """
    A class representing a bank account.
    
    Attributes
    ----------
    balance : float
        The current balance of the account.
    
    Methods
    -------
    deposit(amount)
        Deposits the specified amount into the account.
        
    withdraw(amount)
        Withdraws the specified amount from the account.
    """
    
    def __init__(self, initial_balance):
        """
        Initializes a new BankAccount instance.
        
        Parameters
        ----------
        initial_balance : float
            The initial balance of the account.
        """
        self.__balance = initial_balance

    @property
    def balance(self):
        """
        Returns the current balance of the account.
        """
        return self.__balance

    @balance.setter
    def balance(self, value):
        """
        Sets the current balance of the account to the specified value.
        
        Parameters
        ----------
        value : float
            The new balance of the account.
        """
        if value < 0:
            raise ValueError('Balance cannot be negative.')
        self.__balance = value

    def deposit(self, amount):
        """
        Deposits the specified amount into the account.
        
        Parameters
        ----------
        amount : float
            The amount to be deposited into the account.
        
        Raises
        ------
        ValueError
            If the amount being deposited is negative.
        """
        if amount < 0:
            raise ValueError('Deposit amount cannot be negative.')
        self.__balance += amount

    def withdraw(self, amount):
        """
        Withdraws the specified amount from the account.
        
        Parameters
        ----------
        amount : float
            The amount to be withdrawn from the account.
        
        Raises
        ------
        ValueError
            If the amount being withdrawn is negative or if the account balance is insufficient.
        """
        if amount < 0:
            raise ValueError('Withdrawal amount cannot be negative.')
        if self.__balance < amount:
            raise ValueError('Insufficient funds.')
        self.__balance -= amount

