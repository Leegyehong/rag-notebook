# 파이썬 3.12 버전 사용
FROM python:3.12-slim

# 시스템 필수 패키지 설치 (C++ 빌드 및 라이브러리용)
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 라이브러리 설치 (캐시 활용을 위해 먼저 복사)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 주피터 노트북 및 추가 도구 설치
RUN pip install --no-cache-dir jupyterlab

# 현재 폴더의 모든 파일 복사
COPY . .

# 주피터 노트북 실행 (외부 접속 허용)
EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]