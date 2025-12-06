from fastapi import APIRouter, HTTPException
from app.models.user import UserCreate, UserResponse
from app.crud.users import (
    create_user,
    get_user,
    get_all_users,
    update_user,
    delete_user,
    login_user
)

router = APIRouter(prefix="/users", tags=["Users"])


@router.post("/", response_model=UserResponse)
def create_user_route(user: UserCreate):
    user_id = create_user(user.dict())
    saved_user = get_user(user_id)

    if not saved_user:
        raise HTTPException(status_code=500, detail="Erro ao recuperar usuário criado")

    return saved_user


@router.get("/", response_model=list[UserResponse])
def list_users_route():
    return get_all_users()


@router.get("/{user_id}", response_model=UserResponse)
def get_user_route(user_id: str):
    user = get_user(user_id)

    if not user:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")

    return user


@router.put("/{user_id}", response_model=UserResponse)
def update_user_route(user_id: str, user: UserCreate):
    ok = update_user(user_id, user.dict())

    if not ok:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")

    return get_user(user_id)


@router.delete("/{user_id}", response_model=dict)
def delete_user_route(user_id: str):
    ok = delete_user(user_id)

    if not ok:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")

    return {"status": "deleted"}


@router.post("/login", response_model=UserResponse)
def login_route(credentials: UserCreate):
    user = login_user(credentials.login, credentials.senha)

    if not user:
        raise HTTPException(status_code=401, detail="Credenciais inválidas")

    return user
