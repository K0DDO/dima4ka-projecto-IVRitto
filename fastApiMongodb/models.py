from mongoengine import Document, StringField, ListField, IntField

class User(Document):
    username = StringField()
    password = StringField()
    data = ListField()