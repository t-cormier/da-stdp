


DA-STDP
============

[![badge](https://img.shields.io/badge/Julia-1.4.2-green)](https://julialang.org/downloads/oldreleases/#v142_may_23_2020)

---

## Description

This project aims at reproducing the first results from (Izhikevic, 2007)[1]. The corresponding section of the article is 'Reinforcing a synapse' where the strength of a single synapse of the network is increased through reinforcement learning.
Dopamine (DA) signals often respond to rewarding behaviors and are thus essential to instigate reinforcement learning in the brain. Such a biologically plausible approach to RL is implemented by relying on those dopaminergic signals to gate Hebbian plasticity. Such a learning rule results in increasing the occurences of behaviors leading to rewards.

### DA-STDP

Spike Time Dependent Plasticity (STDP) is a biologically plausible unsupervised learning rule. This local learning rule will strengthen synapses between neurons if their activity is correlated and weaken synapses that connect uncorrelated neurons. However such a learning rule cannot lead to desirable outcome by itself as it is unsupervised. In order to "guide" learning towards solving a task or producing desirable outcomes, the brain relies on dopaminergic signals which are correlated to rewards. Those signals, combined with eligibility traces recording changes due STDP, allow for a higher reward occurence rate.

### Model trained

In this particular experiment, the rewarded behavior is the strengthening of a single synapse (arbitrarily chosen) within a recurrent network of spiking neurons (RSNN).

![dastdp_model](/images/dastdp_model.png)

- The RSNN is composed of 1000 spiking neurons (Izhikevic model) and the conditioned synapse (blue) is randomly selected for the simulation.
- The model is trained for 3600 seconds with DA-STDP.
- The reward is given after a random delay between 1 and 3 seconds.
- Hyperparameters are identical to the ones in the paper.

### Results

![dastdp](/images/dastdpsyn+mean.png)

Reproduction of Figure 1.d of (Izhikevic, 2007). The weight of the conditioned synapse increases to the cap value (blue curve) while the mean synaptic strength in the recurrent network decreases.

---

## Reproducability

- In the directory of your choice run the following terminal command: `git clone https://github.com/t-cormier/da-stdp`
- Open the Julia REPL from within the cloned directory : `cd da-stdp && julia`
- From within the package manager of the Julia REPL (`]`) activate environment `activate dastdp_env`.
- Run `include("main.jl")` from the Julia REPL.

---

## References

<a id="1">[1]</a>
Izhikevic, E. (2007).
Solving the Distal Reward Problem through Linkage of STDP and Dopamine Signaling
Cerebral Cortex, 17(10), 2443-2452.

---

## License

This project is licensed under the terms of the **MIT** license.
