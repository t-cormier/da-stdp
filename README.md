DA-STDP
============

[![badge](https://img.shields.io/badge/Julia-1.4.2-green)](https://julialang.org/downloads/oldreleases/#v142_may_23_2020)

---

## Description

This project aims at reproducing the first results from (Izhikevic, [2007](https://watermark.silverchair.com/bhl152.pdf?token=AQECAHi208BE49Ooan9kkhW_Ercy7Dm3ZL_9Cf3qfKAc485ysgAAAsowggLGBgkqhkiG9w0BBwagggK3MIICswIBADCCAqwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMPU6L5SBwPCyuKVl4AgEQgIICfe_KWYI6mCJ6dj530VXJkZ1jEi6WBA3g3fWVdzXVslFWJPUCXynv2XNI5hpka2HJIn3ABo_whS1ZD3F5FYptt31jAiy9IDivqfaY9pC2ork5vvrUZlaJ45VXF_eoCEKXvJDY_QDetCtYpzS9gEFDlGez62yizpBSjQ9jFUHL8aTxKE-fGTdgG0zj7_lyR4nhV6juRGBBn-sGkaRui-6s1DHkxFeO1UOMmJLEcKHHEiVDkEopCO0UinpsEu_gAzwnE9fVTU8fibTbTDSyEvjanHjL1CJeDym-FEUtmOsU8JJ75hW-yx_h2uw2xrLAfdtL0oEfay9Vfg3Z2uCGkqHUo3D-BAB0_26ENHlqGZA54Q07ZmU93EUMl9aYGQFRj2xHyQdsjIx7obXfWe20snJHh0wE_Olu2YFysQ54Fi8fN1FZ16e426oXB4DBN1qA3xHAF0tcpVJtLWPlEnTRBzyN8Q9md-hvIQD7pKgIjfjV8V_G8QTTQ-gm0YjLDSkipUS8fHsSVHQgyr9xLKDW-moAgZT8Qbnvlm40dN9OOF5ZdKHK-y0LZ18O0f8w65Ej5JViN2b2Hfz87dD2mAx44V081chtFGHTolgasp6xKDV0JmUCN5WoAFi8vpGEk5cHq0V7aMBK2DD6GLK866fg7NkueJwoaFwQor4dXstxdhHvv_Hur_NAKsjOZ2ESKgfuc57gt5RO_qPqcZGxSkL8xyBAoGjPflKhNOYIrHFFZ0Gk1ZqZU-a2gAownqbqni6f5P9V8SOX1xe02Xuq4goktziSuGGSx83BJnuBg3emCA-lIEy97EM5JA9z7ZtUsJN3Jn-C4CLCl0R6Au_u4J6i7UE)). The corresponding section of the article is 'Reinforcing a synapse' where the strength of a single synapse of the network is increased through reinforcement learning.

### Model trained

The model trained in this simulation is a randomly connected Recurrent Spiking Neural Network (RSNN). Each synapse is subject to the biologically plausible learning rule developed in the article called DA-STDP :

$$
\left\{
  \begin{array}{ll}
    \dot{c} = - \frac{c}{\tau_c} \\
  \end{array}
\right.
$$

### Results



---

## Setup/Usage

From within the package manager of the Julia REPL activate environment `activate da-stdp`.
Run `include("main.jl")` from the Julia REPL.

---

## References

<a id="1">[1]</a>
Izhikevic, E. (2007).
Solving the Distal Reward Problem through Linkage of STDP and Dopamine Signaling
Cerebral Cortex, 17(10), 2443-2452.

---

## License

This project is licensed under the terms of the **MIT** license.
