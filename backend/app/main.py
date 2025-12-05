from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers.user_router import router as user_router
from app.routers.pet_router import router as pet_router

origins = [
    "*",
]

app = FastAPI()

app.include_router(user_router)
app.include_router(pet_router)

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)