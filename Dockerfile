# 1. Imagem Base
FROM python:3.13.5-alpine3.22

# 2. Define o diretório de trabalho dentro do container
WORKDIR /app

# 3. Copia o arquivo de dependências
# Copiamos primeiro para aproveitar o cache do Docker. Se o requirements.txt não mudar,
# o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt ./

# 4. Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o restante do código da aplicação
COPY . .

# 6. Expõe a porta que a aplicação vai rodar
EXPOSE 8000

# 7. Comando para iniciar a aplicação quando o container for executado
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
