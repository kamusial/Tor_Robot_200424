from functools import reduce
from operator import mul


def multiply_flex(numbers: list[int]) -> int:
    return reduce(mul, numbers)


def multiply(numbers: list[int]) -> int:
    """
    :param numbers: list of numbers
    :return: result of multiplication of all numbers in list numbers
    """
    result = 1
    for n in numbers:
        result = result * n
    return result


if __name__ == '__main__':
    NUMBERS = [23, 12, 6, 1, 3]
    x = multiply_flex(NUMBERS)
    print(x)
