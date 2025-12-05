from app.core.firebase import db

COLLECTION = "Pets"

def get_pet(user_id: str) -> dict | None:
    doc = db.collection(COLLECTION).document(user_id).get()

    if not doc.exists:
        return None

    data = doc.to_dict()

    return {
        "id": doc.id,
        "nome": data.get("nome"),
        "cor": data.get("cor")
    }


def create_pet(user_id: str, data: dict) -> bool:
    doc_ref = db.collection(COLLECTION).document(user_id)

    doc_ref.set({
        "nome": data["nome"],
        "cor": data["cor"],
    })

    return True
