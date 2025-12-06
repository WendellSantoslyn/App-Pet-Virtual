from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from app.crud.pet import get_pet, create_pet

router = APIRouter(prefix="/pet", tags=["Pet"])

class PetCreate(BaseModel):
    usuario_id: str   # campo enviado pelo Flutter no POST /pet/
    nome: str
    cor: str

@router.get("/{user_id}")
def route_get_pet(user_id: str):
    pet = get_pet(user_id)
    if pet is None:
        raise HTTPException(status_code=404, detail="Pet not found")
    return pet

@router.post("/")
def route_create_pet(payload: PetCreate):
    # payload.usuario_id = id do usuário
    if not payload.usuario_id or not payload.nome or not payload.cor:
        raise HTTPException(status_code=400, detail="Missing required fields")

    success = create_pet(payload.usuario_id, {"nome": payload.nome, "cor": payload.cor})
    if not success:
        raise HTTPException(status_code=500, detail="Failed to create pet")
    return {"message": "Pet created successfully", "user_id": payload.usuario_id}
