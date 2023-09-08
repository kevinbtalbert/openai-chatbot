## Troubleshooting

If user quotas are enabled, ensure you have enough available quota to launch these workloads.
### AMP Failures
CML AMPs cannot be resumed or retried, please relaunch the AMP from the AMP catalog or project creation page.

#### Application Start Hanging/Failure
![image](../images/FAQ_app-fail.png)

Application startup failure or hanging without output is most likely caused by resource limitations in your CML Workspace.

The application requires 1 GPU to perform the LLM text generation.
- Check with your CML workspace administrator to enable GPUs on your CML workspace or to adjust auto-scaling rules for GPUs.
- [CML Documentation: Autoscaling Groups](https://docs.cloudera.com/machine-learning/cloud/security/topics/ml-autoscale-groups.html)

### Text Generation Failures
#### CUDA memory
![image](../images/cuda_mem.png)

The GPU you are launching on may be too small for the LLM and text generation being performed
- Consider relaunching your application with multiple GPUs, the accelerate python package will split the workload accross both GPUs
- Also consider decreasing the size of context documentation you are trying to load, see [Limitations](#limitations)
#### Tensor Size
![image](../images/tensor_size.png)
- The final enhanced prompt input given to the LLM is larger than the prompt limit size of the LLM
- Consider decreasing the size of context documentation you are trying to load, see [Limitations](#limitations)