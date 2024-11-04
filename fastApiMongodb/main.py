from fastapi import FastAPI
from pydantic import BaseModel
from models import User
from mongoengine import connect
import json
from fastapi import HTTPException
from passlib.context import CryptContext

app = FastAPI()
connect(db="mydb", host="localhost", port=27017)

@app.get("/get_all_users")
def get_all_users():
    users_list = json.loads(User.objects().to_json())
    return {"users": users_list}

class NewUser(BaseModel):
    username: str
    password: str
    data: list

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


# Проверяем пароль
def verify_password(plain_password: str, hashed_password: str) -> bool:
    result = pwd_context.verify(plain_password, hashed_password)
    print(f"Verifying password: {plain_password} -> {hashed_password} | Result: {result}")
    return result


# Хешируем пароль
def get_password_hash(password: str) -> str:
    print(f"Hashing password: {password}")  # Отладочный вывод
    return pwd_context.hash(password)


# Аутентификация пользователя
def authenticate_user(username: str, password: str) -> bool:
    print(f"Authenticating user '{username}' with password: {password}")  # Отладка
    user = User.objects(username=username).first()
    if not user:
        print(f"User '{username}' not found.")
        return False
    print(f"Stored hashed password for '{username}': {user.password}")
    return verify_password(password, user.password)


# Регистрация или вход пользователя
@app.post("/signup_or_signin")
async def signup_or_signin(username: str, password: str):
    user = User.objects(username=username).first()

    if user:
        if authenticate_user(username, password):
            user_dict = {
                "username": user.username,
                "data": user.data
            }
            print(f"User '{username}' authenticated successfully.")
            return user_dict
        else:
            raise HTTPException(status_code=400, detail="Incorrect username or password")

    # Если пользователь не найден, создаем нового
    new_user = User(
        username=username,
        password=get_password_hash(password),
        data=[]
    )
    try:
        new_user.save()
        user_dict = {
            "username": new_user.username,
            "data": new_user.data
        }
        print(f"User '{username}' created successfully.")
        return user_dict
    except Exception as e:
        print(f"Error creating user: {e}")
        raise HTTPException(status_code=500, detail="Failed to create user")

@app.get("/load_data")
def load_data(username: str):
    user = User.objects(username=username).first()
    return user.data

from fastapi.encoders import jsonable_encoder

@app.put("/save_data/{username}")
async def save_data(username: str, game_data: dict):
    user = User.objects.get(username=username)
    found_item = next((item for item in user.data if item.get("playername") == game_data.get("playername")), None)
    if found_item:
        for key, value in game_data.items():
            found_item[key] = value
        user_data_new = user.data
    else:
        game_data_encoded = jsonable_encoder(game_data)
        user_data_new = user.data
        user_data_new.append(game_data_encoded)
        user.data = user_data_new
    user.save()
    return {"username": username, "data": user_data_new}
