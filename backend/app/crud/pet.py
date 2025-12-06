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
    # grava doc com id = user_id (1 pet por user)
    try:
        db.collection(COLLECTION).document(user_id).set({
            "nome": data["nome"],
            "cor": data["cor"],
        })
        # atualiza usuário para marcar hasPet = True (se existir Users collection)
        try:
            db.collection("Users").document(user_id).update({"hasPet": True})
        except Exception:
            # ignora se user doc não existir ou update falhar
            pass
        return True
    except Exception as e:
        print("Erro ao criar pet:", e)
        return False
