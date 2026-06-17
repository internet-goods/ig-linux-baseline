#AI OVERLORDS GO!
echo AI1 Python LLM ACTIVE
apt -y install llm
llm install claude
llm install llm-gpt4all
python3 -m venv myllm_env
cd myllm_env 
source bin/activate  
python3 -m pip install --upgrade gpt4all typer typing-extensions
#python hellllm install llm-gpt4all
wget https://raw.githubusercontent.com/nomic-ai/gpt4all/main/gpt4all-bindings/cli/app.py
python3 app.py repl
echo AI2 OLLAMA
curl https://ollama.ai/install.sh | sh
echo AI3 WEKA INACTIVE
#pdsh -R ssh -w "weka0-[0-7]" "curl https://[GET.WEKA.IO-TOKEN]@get.weka.io/dist/v1/install/4.0.5.14/4.0.5.14 | sh
echo AI4 Openclaw INACTIVE
#curl -fsSL https://openclaw.ai/install.sh | bash
