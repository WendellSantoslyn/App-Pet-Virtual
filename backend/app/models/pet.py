from pydantic import BaseModel

class PetCreate(BaseModel):
    nome: str
    cor: str

class PetResponse(BaseModel):
    userId: str
    nome: str
    cor: str
