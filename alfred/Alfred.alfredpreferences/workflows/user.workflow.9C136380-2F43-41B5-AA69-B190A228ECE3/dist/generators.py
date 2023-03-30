from uuid import uuid4
from string import ascii_lowercase, ascii_uppercase
from random import choice, randint

LETTER_VALUES = dict(zip(ascii_uppercase, filter(lambda i: i % 11, range(10, 39))))


def random_string(size=10):
    return "".join(choice(ascii_lowercase + ascii_uppercase) for _ in range(size))


def random_email():
    return "".join([random_string(10), "@", random_string(7), ".com"]).lower()


def random_imei():
    imei = [randint(0, 9) for _ in range(14)]

    tmp = []

    for index, digit in enumerate(imei):
        if index % 2:
            digit = digit * 2

        tmp.extend(divmod(digit, 10))

    imei.append((sum(tmp) * 9) % 10)
    return "".join(map(str, imei))


def random_unit_number():
    number = [
        choice(ascii_uppercase),
        choice(ascii_uppercase),
        choice(ascii_uppercase),
        choice("UJZ"),
        randint(0, 9),
        randint(0, 9),
        randint(0, 9),
        randint(0, 9),
        randint(0, 9),
        randint(0, 9),
    ]

    values = list(map(lambda d: int(LETTER_VALUES.get(d, d)), number))
    checksum = sum(d * 2**i for i, d in enumerate(values)) % 11

    if checksum > 9:
        return random_unit_number()

    number.append(checksum)
    return "".join(map(str, number))


def random_uuid():
    return str(uuid4())
