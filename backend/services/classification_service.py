from transformers import pipeline

classifier = pipeline(
    "zero-shot-classification",
    model="facebook/bart-large-mnli"
)

URGENCY_LABELS = [
    "Routine issue that can wait",
    "Urgent problem requiring quick attention",
    "Emergency situation needing immediate help"
]

LABEL_MAPPING = {
    "Routine issue that can wait": "Routine",
    "Urgent problem requiring quick attention": "Urgent",
    "Emergency situation needing immediate help": "Emergency",
}

DANGER_KEYWORDS = [
    "bridge",
    "highway",
    "fire",
    "flood",
    "gas leak",
    "smoke",
    "sparks",
    "accident",
    "trapped",
]

def analyze_description(description: str):

    result = classifier(
        description,
        URGENCY_LABELS,
        hypothesis_template="The urgency level of this issue is {}."
    )

    top_label = result["labels"][0]

    urgency = LABEL_MAPPING[top_label]

    confidence = round(result["scores"][0], 2)

    text_lower = description.lower()

    if any(word in text_lower for word in DANGER_KEYWORDS):

        if urgency == "Urgent":
            urgency = "Emergency"

        confidence = min(confidence + 0.20, 0.99)

    return {
        "urgency": urgency,
        "confidence": confidence,
    }