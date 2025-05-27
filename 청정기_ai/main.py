from fastapi import FastAPI
from pydantic import BaseModel
from policy_model import search_policy_and_generate_reason

app = FastAPI()

class PolicyRequest(BaseModel):
    input: str

@app.post("/predict")
def predict(req: PolicyRequest):
    result = search_policy_and_generate_reason(req.input)
    return result
