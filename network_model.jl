using LinearAlgebra


mutable struct Network

    n_exc::Int64
    n_neurons::Int64

    v::Array{Float64}
    u::Array{Float64}
    d::Array{Float64}
    a::Array{Float64}

    connection::Array{Int64,2}
    s::Array{Float64,2}
    sd::Array{Float64,2}
    STDP::Array{Float64}

    exc::Array{Int64}
    inh::Array{Int64}

    I::Array{Float64}
    da::Float64
    arch::Array{Int64}
    #param::Dict

    function connect(n_neurons::Int64, n_exc::Int64, connectivity::Float64,
                     arch::Array{Int64})
        if arch == [0]
            connection = (rand(n_neurons,n_neurons) .< connectivity)
        else
            architr = [0; arch]
            connection = zeros(n_neurons,n_neurons)
            for i in 1:length(architr)-2
                si1 = sum(architr[1:i])
                si2 = sum(architr[1:i+1])
                si3 = sum(architr[1:i+2])
                ai2 = architr[i+1]
                ai3 = architr[i+2]
                connection[1+si1:si2,1+si2:si3] .= ones(ai2,ai3)
            end
            archinh = [0;arch[2:end-1]]
            for i in 1:length(archinh)-1
                sii1 = sum(archinh[1:i])
                sii2 = sum(archinh[1:i+1])
                si2 = sum(architr[1:i+1])
                si3 = sum(architr[1:i+2])
                a2 = arch[i+1]
                connection[n_exc+sii1+1:n_exc+sii2, si2+1:si3] .= ones(a2,a2) .- I(a2)
                connection[si2+1:si3, n_exc+sii1+1:n_exc+sii2] .= I(a2)
            end
        end
        exc = collect(1:n_exc)
        inh = collect(n_exc+1:n_neurons)
        return connection, exc, inh
    end

    function Network(arch::Array{Int64})
        n_exc = sum(arch)
        n_neurons = n_exc+sum(arch[2:end-1])
        v = -65.0*ones(n_neurons) #parameter
        u = 0.2 * v # parameter
        d = [(i<=n_exc) ? 8.0 : 2.0 for i in 1:n_neurons] # parameter
        a = [(i<=n_exc) ? 0.02 : 0.1 for i in 1:n_neurons] # parameter
        n_inh = n_neurons-n_exc
        connection, exc, inh = connect(n_neurons, n_exc, 0.1, arch)
        s = zeros(n_neurons,n_neurons)
        # maybe set the Exc-> Inh conn weights to high value
        s[exc,:] .= 1.0 .* ones(n_exc, n_neurons) # parameter
        s[inh,:] .= -1.0 .* ones(n_inh, n_neurons) # paramter
        s .*= connection
        sd = zeros(n_neurons,n_neurons)
        STDP = zeros(n_neurons)
        I = Float64[]
        da = 0.0
        arch = arch
        new(n_exc,n_neurons,v,u,d,a,connection,s,sd,STDP,exc,inh,I,da,arch)
    end

    function Network(n_neurons::Int64, connectivity::Float64, n_exc::Int64)
        v = -65.0*ones(n_neurons)
        u = 0.2 * v
        d = [(i<=n_exc) ? 8.0 : 2.0 for i in 1:n_neurons]
        a = [(i<=n_exc) ? 0.02 : 0.1 for i in 1:n_neurons]
        n_inh = n_neurons-n_exc
        connection, exc, inh = connect(n_neurons, n_exc, connectivity, [0])
        s = zeros(n_neurons,n_neurons)
        # maybe set the Exc-> Inh conn weights to high value
        s[exc,:] .= 1.0 .* ones(n_exc, n_neurons)
        s[inh,:] .= -1.0 .* ones(n_inh, n_neurons)
        s .*= connection
        sd = zeros(n_neurons,n_neurons)
        STDP = zeros(n_neurons)
        I = Float64[]
        da = 0.0
        arch = [0]
        new(n_exc,n_neurons,v,u,d,a,connection,s,sd,STDP,exc,inh,I,da,arch)
    end
end


# %% functions

function input!(net::Network, input_spikes::Array{Int64})
    net.v[input_spikes] .= 40.0 # parameter
end


function spike!(net::Network)
    # spikes
    net.I = 13 .* (rand(length(net.STDP)) .- 0.5) # parameter
    spiked = findall(x->x>30,net.v) # parameter
    net.v[spiked] .= -65.0 # parameter
    net.u[spiked] .+= net.d[spiked]
    # increment current
    for neuron in spiked
        net.I .+= net.s[neuron,:]
    end
    #time step (Izhikevic model)
    net.v .= @. net.v+0.5*((0.04*net.v+5)*net.v+140-net.u+net.I) # parametersss
    net.v .= @. net.v+0.5*((0.04*net.v+5)*net.v+140-net.u+net.I)
    net.u .= @. net.u+net.a*(0.2*net.v-net.u)   # parameters
    net.STDP[spiked] .= 0.1  # parameter
    # LTP & LTD
    for neuron in spiked
        net.sd[:,neuron] .+= 1.0 .* net.STDP #parameter
        net.sd[neuron,:] .-= 1.5 .* net.STDP # parameter
    end
    # time decay
    net.STDP .*= 0.95 # parameter
    net.da *= 0.995 # parameter
    spiked
end

function learn!(net::Network)
    #increase the synaptic weigths
    net.s[net.exc,:] .+= (0.002+net.da) .* net.sd[net.exc,:]  # parameters
    net.s[net.exc,:] .= clamp.(net.s[net.exc,:], 0, 4) # parameters
    net.s .*= net.connection
    # time decay
    net.sd .*= 0.99 # parameter
end

# %% main functions

function step!(net::Network, train::Bool=false)
    spiked = spike!(net)
    if train
        learn!(net)
    end
    spiked
end

function step!(net::Network, input_spikes::Array{Int64}, train::Bool=false)
    input!(net,input_spikes)
    spiked = spike!(net)
    if train
        learn!(net)
    end
    spiked
end
