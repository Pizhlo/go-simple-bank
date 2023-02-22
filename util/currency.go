package util

// Constants for all supported currencies
const (
	USD = "USD"
	EUR = "EUR"
)

func IsSupportedCurrency(currency string) bool {
	switch currency {
	case USD, EUR:
		return true
	}
	return false
}
