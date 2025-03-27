import azure.functions as func
import logging
import openai
import os
import json

openai.api_key = os.getenv("OPENAI_API_KEY")
openai.api_base = os.getenv("OPENAI_ENDPOINT")
openai.api_version = '2023-05-15'

app = func.FunctionApp()

@app.function_name(name="OpenAIAlertHandler")
@app.route(route="OpenAIAlertHandler", auth_level=func.AuthLevel.FUNCTION, methods=["POST"])
def OpenAIAlertHandler(req: func.HttpRequest) -> func.HttpResponse:
    data = req.get_json()
    prompt = f"""
    Sou analista SRE.
    Recebi o alerta: {data['alerta']}, {data['count']} vezes em {data['periodo']}.
    Qual a causa provável e sugira uma ação imediata curta e prática.
    """

    completion = openai.ChatCompletion.create(
        engine="gpt-35-turbo",
        messages=[{"role": "user", "content": prompt}]
    )

    resposta = completion['choices'][0]['message']['content']
    logging.info(f"Resposta OpenAI: {resposta}")

    return func.HttpResponse(
        json.dumps({"diagnostico": resposta}),
        status_code=200,
        mimetype="application/json"
    )

