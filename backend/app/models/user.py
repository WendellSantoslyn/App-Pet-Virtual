from pydantic import BaseModel

class UserCreate(BaseModel):
    login: str
    senha: str

class UserResponse(BaseModel):
    id: str
    login: str
    senha: str
