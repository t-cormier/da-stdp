
include("network_model.jl")
using Statistics

# %%

n = Network(1000, 0.1, 800)

# %%

function post(neuron,connection)
    return findall(x->x==1,connection[neuron,:]) # change for new_net_col
end

const n1 = 2
const n2 = post(n1,n.connection)[1]
const interval = 20 #msec

n.s[n1,n2] = 0.0
n1f = [-100]
n2f = Int64[]
rew = Int64[]

function reward!(n1f::Array{Int64},n2f::Array{Int64},rew::Array{Int64},spiked::Array{Int64},time::Int64) # Module DA_STDP
    if n1 in spiked
        append!(n1f,time)
    end
    if n2 in spiked
        append!(n2f,time)
        if (time-last(n1f)<interval) && (last(n2f)>last(n1f))
            append!(rew,time+1000+rand(1:2000))
        end
    end
end

shist = zeros(10*3601,3)

idx = findall(x -> x != 0, n.connection)

# %%



@inbounds for sec in 0:3600
    @show sec
    @time @inbounds for msec in 1:1000
        time = 1000*sec+msec
        train = false
        if msec%10 == 0
            train = true
        end
        spiked = step!(n,train)
        reward!(n1f,n2f,rew,spiked,time)
        if time in rew
            n.da += 0.5
        end
        if msec%100==0
            shist[div(time,100),1:2] .= n.s[n1,n2],n.sd[n1,n2] # change for new_net_col
            shist[div(time,100),3] = mean(n.s[idx])
        end
    end
end


# %% Plot learning of the targeted synapse
using Plots
gr()
x1 = 0.1.*collect(1:length(shist[:,1]))
y1 = shist[:,1]
x2 = x1
y2 = shist[:,2]
y3 = shist[:,3]
fig = plot()
plot!(x1,y1,color="blue",label="synapse weight", legend = true)
plot!(x2,y2,color="green",label="eligibilty trace", legend = true)
plot!(x2, y3, color = "grey", label = "mean weight", legend = true)
xlabel!("Time (sec)")
