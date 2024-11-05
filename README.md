# vllm-serving-benchmark
Follow this instructions to run inference benchmark using vllm backend:
```
docker build -t vllm-benchmark-docker .
```


docker run --runtime nvidia --gpus all --name "Meta-Llama-3.1-70B-Instruct-GPTQ-INT4-vLLM-benchmark" \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    -p 8000:8000 \
    --ipc=host \
    vllm/vllm-openai:v0.6.2 \
    --model hugging-quants/Meta-Llama-3.1-70B-Instruct-GPTQ-INT4 \
    --quantization gptq \
    --dtype=half \
    --tensor-parallel-size 4 \
    --disable-log-stats \
    --max-model-len 10480 \
    --max-num-seqs 200 \
    --gpu-memory-utilization 1.0 \
    vllm-benchmark-docker python benchmarks/benchmark_serving.py \
    --backend vllm \
    --endpoint /v1/chat/completions \
    --max-concurrency 100 \
    --model Meta-Llama-3.1-70B-Instruct-GPTQ-INT4 \
    --tokenizer Meta-Llama-3.1-70B-Instruct-GPTQ-INT4 \
    --num-prompts 100 \
    --save-result


docker run --runtime nvidia --gpus all --name "TinyLlama-1.1B-Chat-v1.0-GPTQ-vLLM-benchmark" \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    -p 8000:8000 \
    --ipc=host \
    vllm/vllm-openai:v0.6.2 \
    --model TheBloke/TinyLlama-1.1B-Chat-v1.0-GPTQ \
    --quantization gptq \
    --dtype=half \
    --disable-log-stats \
    --gpu-memory-utilization 0.9 \
    vllm-benchmark-docker python benchmarks/benchmark_serving.py \
    --backend vllm \
    --endpoint /v1/chat/completions \
    --max-concurrency 100 \
    --model TinyLlama-1.1B-Chat-v1.0-GPTQ \
    --tokenizer TinyLlama-1.1B-Chat-v1.0-GPTQ \
    --num-prompts 100 \
    --save-result