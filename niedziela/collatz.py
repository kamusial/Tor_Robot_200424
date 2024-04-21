def collatz_iteration(n):
    if n % 2 == 0:
        result = n // 2
    else:
        result = n * 3 + 1
    print(result)
    return result


x = collatz_iteration(3)
y = collatz_iteration(x)
z = collatz_iteration(y)
