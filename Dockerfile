FROM nvidia/cuda:12.3.2-cudnn9-devel-ubuntu22.04

RUN apt-get update && apt-get install -y python3 python3-pip git cmake
RUN pip install --upgrade pip setuptools
RUN pip install cmake>=3.26
RUN pip install numpy

WORKDIR /app

# RUN git config --global http.postBuffer 104857600
RUN git clone https://github.com/vllm-project/vllm.git
WORKDIR /app/vllm
RUN cd vllm
RUN pip install -e . -v

# COPY ~/.cache/huggingface /root/.cache/huggingface

# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# ENV ENDPOINT="/v1/chat/completions"
# ENV MAX_CONCURRENCY=100
# ENV MODEL="Meta-Llama-3.1-70B-Instruct-GPTQ-INT4"
# ENV NUM_PROMPTS=100
# CMD ["python", "benchmarks/benchmark_serving.py", \
#      "--backend", "vllm", \
#      "--endpoint", "${ENDPOINT}", \
#      "--max-concurrency", "${MAX_CONCURRENCY}", \
#      "--model", "${MODEL}", \
#      "--tokenizer", "${MODEL}", \
#      "--num-prompts", "${NUM_PROMPTS}", \
#      "--save-result"]