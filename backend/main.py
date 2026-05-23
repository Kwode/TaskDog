from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import analyze

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins = ["*"],
    allow_credentials = True,
    allow_headers = ["*"],
    allow_methods = ["*"]
)

app.include_router(analyze.router)