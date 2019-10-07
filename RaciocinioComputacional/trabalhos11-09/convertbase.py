import string


class Convert_Base():
    def __init__(self):
        # 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
        self.arr_digits = string.digits + string.ascii_letters 

    def convert_to_any_base(self, num, base):
        if num < 0:
            sign = -1
        elif num == 0:
            return self.arr_digits[0]
        else:
            sign = 1

        num *= sign
        digits = []

        while num:
            digits.append(self.arr_digits[int(num % base)])
            num = int(num / base)

        if sign < 0:
            digits.append('-')

        digits.reverse()

        return ''.join(digits)

convert = Convert_Base()
print('Convertendo 10 para base 2: ', convert.convert_to_any_base(10, 2))
print('Convertendo 16 para base 16: ', convert.convert_to_any_base(16, 16))
print('Convertendo 10 para base 8: ', convert.convert_to_any_base(10, 8))