from fastapi import APIRouter
from services.classification_service import analyze_description
from schemas.request_schema import AnalyzeRequest


router = APIRouter()

@router.post('/analyze')
def analyze(description: AnalyzeRequest):
    return analyze_description(description = description.description)