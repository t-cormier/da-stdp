


DA-STDP
============

[![badge](https://img.shields.io/badge/Julia-1.4.2-green)](https://julialang.org/downloads/oldreleases/#v142_may_23_2020)

---

## Description

This project aims at reproducing the first results from (Izhikevic, 2007)[1]. The corresponding section of the article is 'Reinforcing a synapse' where the strength of a single synapse of the network is increased through reinforcement learning.

### Model trained

The model trained in this simulation is a randomly connected Recurrent Spiking Neural Network (RSNN). Each synapse is subject to the biologically plausible learning rule developed in the article called DA-STDP :



### Results



---

## Setup/Usage

+In the directory of your choice run the following terminal command: `git clone https://github.com/t-cormier/da-stdp`
+From within the package manager of the Julia REPL activate environment `activate dastdp_env`.
+Run `include("main.jl")` from the Julia REPL.

---

## References

<a id="1">[1]</a>
Izhikevic, E. (2007).
Solving the Distal Reward Problem through Linkage of STDP and Dopamine Signaling
Cerebral Cortex, 17(10), 2443-2452.

---

## License

This project is licensed under the terms of the **MIT** license.
