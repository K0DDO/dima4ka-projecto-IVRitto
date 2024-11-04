import bcrypt

# Тестируемый пароль
password = b"1234"

# Генерация нового хеша
new_hash = bcrypt.hashpw(password, bcrypt.gensalt())
print(f"Newly generated hash: {new_hash}")

# Проверка с новым хешем
is_valid_new = bcrypt.checkpw(password, new_hash)
print(f"Verifying with newly generated hash: {is_valid_new}")  # Ожидается True

known_hash = b"$2b$12$MadOkdQad3ngdsvLMguF1O1AsHrlR1FAp2/y2wjAr041D0yFU8aRS"

# Проверка нового пароля с известным хешем
is_valid_known = bcrypt.checkpw(password, known_hash)
print(f"Verifying '1234' with known hash: {is_valid_known}")  # Ожидается False, если хеш неправильный

# Генерация нового хеша с паролем '1234'
new_known_hash = bcrypt.hashpw(b"1234", bcrypt.gensalt())
print(f"Newly generated known hash: {new_known_hash}")

# Сравни его с известным хешем
is_valid_final = bcrypt.checkpw(b"1234", new_known_hash)
print(f"Validating generated known hash: {is_valid_final}")  # Ожидается True
