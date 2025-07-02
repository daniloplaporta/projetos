# 1. Imagem Base
# Usamos uma imagem oficial do Python. A tag 'slim' indica uma versão mínima,
# o que resulta em uma imagem final menor e mais segura.
FROM python:3.10-slim

# 2. Variáveis de Ambiente
# Define variáveis de ambiente para boas práticas com Python em contêineres.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 4. Instalação de Dependências
# Copia primeiro o arquivo de dependências e as instala.
# Isso aproveita o cache do Docker: se o requirements.txt não mudar,
# esta camada não será reconstruída, acelerando o processo de build.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Cópia do Código da Aplicação
# Copia o restante do código da sua aplicação para o diretório de trabalho.
COPY . .

# 6. Comando de Execução
# Define o comando para iniciar a aplicação usando Uvicorn.
# O host '0.0.0.0' é essencial para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

