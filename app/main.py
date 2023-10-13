from fastapi import FastAPI
import random 


app = FastAPI()


@app.get("/")
def read_root():
    return {"roldl" : random.randint(1,6)}
