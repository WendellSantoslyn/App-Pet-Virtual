from fastapi import APIRouter, HTTPException
from app.crud.pet import get_pet, create_pet

router = APIRouter(prefix="/pet", tags=["Pet"])

@router.get("/{user_id}")
def route_get_pet(user_id: str):
    pet = get_pet(user_id)

    if pet is None:
        raise HTTPException(status_code=404, detail="Pet not found")

    return pet


@router.post("/{user_id}")
def route_create_pet(user_id: str, data: dict):
    if "name" not in data or "color" not in data:
        raise HTTPException(status_code=400, detail="Missing required fields")

    success = create_pet(user_id, data)

    if not success:
        raise HTTPException(status_code=500, detail="Failed to create pet")

    return {"message": "Pet created successfully", "user_id": user_id}