from app.core.firebase import db

COLLECTION = "Users"


def create_user(data: dict) -> str:
    ref = db.collection(COLLECTION).add({
        "login": data["login"],
        "senha": data["senha"],
    })
    return ref[1].id


def get_user(user_id: str) -> dict | None:
    doc = db.collection(COLLECTION).document(user_id).get()

    if not doc.exists:
        return None

    data = doc.to_dict()

    return {
        "id": doc.id,
        "login": data.get("login"),
        "senha": data.get("senha")
    }


def get_all_users() -> list[dict]:
    docs = db.collection(COLLECTION).get()

    users = []
    for doc in docs:
        data = doc.to_dict()
        users.append({
            "id": doc.id,
            "login": data.get("login"),
            "senha": data.get("senha")
        })

    return users


def update_user(user_id: str, data: dict) -> bool:
    doc_ref = db.collection(COLLECTION).document(user_id)

    if not doc_ref.get().exists:
        return False

    doc_ref.update({
        "login": data["login"],
        "senha": data["senha"],
    })
    return True


def delete_user(user_id: str) -> bool:
    doc_ref = db.collection(COLLECTION).document(user_id)

    if not doc_ref.get().exists:
        return False

    doc_ref.delete()
    return True


def login_user(login: str, senha: str) -> dict | None:
    query = db.collection(COLLECTION).where("login", "==", login).limit(1).get()

    if not query:
        return None

    doc = query[0]
    data = doc.to_dict()

    if data.get("senha") != senha:
        return None

    return {
        "id": doc.id,
        "login": data.get("login"),
        "senha": data.get("senha")
    }
