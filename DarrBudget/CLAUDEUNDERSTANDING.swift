//
//  CLAUDEUNDERSTANDING.swift
//  
//
//  Created by Isaac D2 on 11/10/24.
//
/*
import Foundation

// MARK: - Enhanced Budget Status
struct BudgetStatus {
    let planned: Decimal
    let actual: Decimal
    let remaining: Decimal
    let rolloverFromPrevious: Decimal  // Amount rolled over from previous month
    let totalAvailable: Decimal        // planned + rolloverFromPrevious
    
    init(planned: Decimal, actual: Decimal, rolloverFromPrevious: Decimal = 0) {
        self.planned = planned
        self.actual = actual
        self.rolloverFromPrevious = rolloverFromPrevious
        self.totalAvailable = planned + rolloverFromPrevious
        self.remaining = totalAvailable - actual
    }
}

// MARK: - Budget Manager
class BudgetManager {
    private var monthlyBudgets: [MonthlyBudget]
    
    init() {
        self.monthlyBudgets = []
    }
    
    // Add a method to store monthly budgets
    func addMonthlyBudget(_ budget: MonthlyBudget) {
        if let index = monthlyBudgets.firstIndex(where: { $0.id == budget.id }) {
            monthlyBudgets[index] = budget
        } else {
            monthlyBudgets.append(budget)
        }
        monthlyBudgets.sort { ($0.year, $0.month) < ($1.year, $1.month) }
    }
    
    // Get budget status showing planned vs actual amounts with rollovers
    func getBudgetStatus(monthlyBudget: MonthlyBudget) -> [CategoryType: BudgetStatus] {
        var status: [CategoryType: BudgetStatus] = [:]
        
        for budget in monthlyBudget.budgets {
            let actual = monthlyBudget.transactions
                .filter { $0.category == budget.category && $0.type == .expense }
                .reduce(0) { $0 + $1.amount }
            
            // Calculate rollover from previous months
            let rollover = calculateRolloverAmount(
                forCategory: budget.category,
                currentYear: monthlyBudget.year,
                currentMonth: monthlyBudget.month
            )
            
            status[budget.category] = BudgetStatus(
                planned: budget.plannedAmount,
                actual: actual,
                rolloverFromPrevious: rollover
            )
        }
        
        return status
    }
    
    // Calculate rollover amount from all previous months up to the specified month
    private func calculateRolloverAmount(
        forCategory category: CategoryType,
        currentYear: Int,
        currentMonth: Int
    ) -> Decimal {
        var totalRollover: Decimal = 0
        
        // Get all previous months' budgets, sorted chronologically
        let previousMonths = monthlyBudgets.filter { budget in
            (budget.year < currentYear) ||
            (budget.year == currentYear && budget.month < currentMonth)
        }.sorted { ($0.year, $0.month) < ($1.year, $1.month) }
        
        // Calculate cumulative rollover
        for monthBudget in previousMonths {
            if let budget = monthBudget.budgets.first(where: { $0.category == category }) {
                let actual = monthBudget.transactions
                    .filter { $0.category == category && $0.type == .expense }
                    .reduce(0) { $0 + $1.amount }
                
                // Add unused amount to rollover
                totalRollover += budget.plannedAmount - actual
            }
        }
        
        return totalRollover
    }
    
    // Enhanced monthly analysis with rollover information
    func getMonthlyAnalysis(for monthlyBudget: MonthlyBudget) -> MonthlyAnalysis {
        let totalIncome = monthlyBudget.transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let totalExpenses = monthlyBudget.transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        var categoryTotals: [CategoryType: Decimal] = [:]
        for category in CategoryType.allCases {
            let total = monthlyBudget.transactions
                .filter { $0.category == category && $0.type == .expense }
                .reduce(0) { $0 + $1.amount }
            categoryTotals[category] = total
        }
        
        return MonthlyAnalysis(
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
            categoryTotals: categoryTotals,
            budgetStatus: getBudgetStatus(monthlyBudget: monthlyBudget)
        )
    }
    
    // Example usage function
    func printBudgetStatus(for monthlyBudget: MonthlyBudget) {
        let status = getBudgetStatus(monthlyBudget: monthlyBudget)
        
        print("Budget Status for \(monthlyBudget.year)-\(monthlyBudget.month):")
        for (category, budgetStatus) in status {
            print("\(category):")
            print("  Planned: \(budgetStatus.planned)")
            print("  Rollover from previous: \(budgetStatus.rolloverFromPrevious)")
            print("  Total Available: \(budgetStatus.totalAvailable)")
            print("  Actual Spent: \(budgetStatus.actual)")
            print("  Remaining: \(budgetStatus.remaining)")
            print("")
        }
    }
}

// MARK: - Budget Manager
class BudgetManager {
    private var monthlyBudgets: [MonthlyBudget]
    
    init() {
        self.monthlyBudgets = []
    }
    
    // Creates a new month based on the previous month's recurring items
    func createNextMonth(from currentMonth: MonthlyBudget) -> MonthlyBudget {
        let (nextYear, nextMonth) = getNextMonth(year: currentMonth.year, month: currentMonth.month)
        
        return MonthlyBudget(
            id: UUID(),
            year: nextYear,
            month: nextMonth
        )
    }
    
    // Helper to calculate the next month
    private func getNextMonth(year: Int, month: Int) -> (year: Int, month: Int) {
        if month == 12 {
            return (year + 1, 1)
        } else {
            return (year, month + 1)
        }
    }
    
    // Helper to calculate next date for recurring transactions
    private func calculateNextDate(from date: Date, frequency: RecurringFrequency) -> Date {
        let calendar = Calendar.current
        switch frequency {
        case .monthly:
            return calendar.date(byAdding: .month, value: 1, to: date) ?? date
        case .quarterly:
            return calendar.date(byAdding: .month, value: 3, to: date) ?? date
        case .annual:
            return calendar.date(byAdding: .year, value: 1, to: date) ?? date
        }
    }
    
    // Get analysis for a specific month
    func getMonthlyAnalysis(for monthlyBudget: MonthlyBudget) -> MonthlyAnalysis {
        let totalIncome = monthlyBudget.transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let totalExpenses = monthlyBudget.transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        var categoryTotals: [CategoryType: Decimal] = [:]
        for category in CategoryType.allCases {
            let total = monthlyBudget.transactions
                .filter { $0.category == category && $0.type == .expense }
                .reduce(0) { $0 + $1.amount }
            categoryTotals[category] = total
        }
        
        return MonthlyAnalysis(
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
            categoryTotals: categoryTotals,
            budgetStatus: getBudgetStatus(monthlyBudget: monthlyBudget)
        )
    }
    
    // Get budget status showing planned vs actual amounts
    private func getBudgetStatus(monthlyBudget: MonthlyBudget) -> [CategoryType: BudgetStatus] {
        var status: [CategoryType: BudgetStatus] = [:]
        
        for budget in monthlyBudget.budgets {
            let actual = monthlyBudget.transactions
                .filter { $0.category == budget.category && $0.type == .expense }
                .reduce(0) { $0 + $1.amount }
            
            status[budget.category] = BudgetStatus(
                planned: budget.plannedAmount,
                actual: actual,
                remaining: budget.plannedAmount - actual
            )
        }
        
        return status
    }
}

// MARK: - Analysis Types
struct MonthlyAnalysis {
    let totalIncome: Decimal
    let totalExpenses: Decimal
    let categoryTotals: [CategoryType: Decimal]
    let budgetStatus: [CategoryType: BudgetStatus]
}

struct BudgetStatus {
    let planned: Decimal
    let actual: Decimal
    let remaining: Decimal
}

// MARK: - Usage Example
func example() {
    let manager = BudgetManager()
    
    // Create January budget
    let januaryBudget = MonthlyBudget(
        id: UUID(),
        year: 2024,
        month: 1,
        budgets: [
            Budget(
                id: UUID(),
                plannedAmount: 1500,
                category: .housing,
                isRecurring: true  // This budget will automatically copy to next month
            )
        ],
        transactions: [
            Transaction(
                id: UUID(),
                amount: 1500,
                description: "Rent",
                category: .housing,
                type: .expense,
                date: Date(),
                isRecurring: true,  // This transaction will automatically copy to next month
                recurringFrequency: .monthly,
                notes: nil
            )
        ]
    )
    
    // Create February budget based on January's recurring items
    let februaryBudget = manager.createNextMonth(from: januaryBudget)
    
    // Get analysis for January
    let januaryAnalysis = manager.getMonthlyAnalysis(for: januaryBudget)
}
*/
