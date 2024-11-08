# vllm-serving-benchmark
Follow these instructions to run inference benchmark using vllm backend.

1) First create the container:
```
docker run --runtime nvidia \
  --name "Meta-Llama-3.1-70B-Instruct-AWQ-INT4-vLLM" \
  --rm \
  --gpus all \
  --ipc=host \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -p 8001:8000 \
  -e OMP_NUM_THREADS=1 \
  vllm/vllm-openai:latest \
  --model hugging-quants/Meta-Llama-3.1-70B-Instruct-AWQ-INT4 \
  --quantization awq \
  --dtype=half \
  --tensor-parallel-size 4 \
  --disable-log-stats \
  --max-model-len 10480 \
  --max-num-seqs 200 \
  --gpu-memory-utilization 1.0
```

2. Enter the ocntainer and clone vllm repository:
```
git clone https://github.com/vllm-project/vllm.git && cd vllm

```

3. Run the benchmark:

```
python3 benchmarks/benchmark_serving.py \
  --dataset-name sharegpt \
  --dataset-path ../data/ShareGPT_V3_unfiltered_cleaned_split.json \
  --model hugging-quants/Meta-Llama-3.1-70B-Instruct-GPTQ-INT4 \
  --tokenizer hugging-quants/Meta-Llama-3.1-70B-Instruct-GPTQ-INT4 \
  --num-prompts 40 \
  --save-result
```